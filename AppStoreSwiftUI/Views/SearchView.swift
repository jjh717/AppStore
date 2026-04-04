//
//  SearchView.swift
//  AppStoreSwiftUI
//
//  Created by jjh717
//

import SwiftUI

struct SearchView: View {
    @State private var viewModel = SearchViewModel()
    @State private var searchText = ""
    @State private var isSearchFieldActive = false

    var body: some View {
        NavigationStack {
            List {
                if viewModel.isLoading {
                    HStack {
                        Spacer()
                        ProgressView("Searching...")
                        Spacer()
                    }
                    .listRowSeparator(.hidden)
                } else if viewModel.isSearching {
                    ForEach(viewModel.searchResults) { appInfo in
                        NavigationLink(value: appInfo) {
                            AppListRow(appInfo: appInfo)
                        }
                    }
                } else if !viewModel.filteredHistory.isEmpty {
                    Section("Recent Searches") {
                        ForEach(viewModel.filteredHistory, id: \.self) { term in
                            Button {
                                searchText = term
                                Task { await viewModel.search(term: term) }
                            } label: {
                                Label {
                                    highlightedText(term, highlight: searchText)
                                } icon: {
                                    Image(systemName: "magnifyingglass")
                                        .foregroundStyle(.secondary)
                                }
                            }
                        }
                    }
                }
            }
            .listStyle(.plain)
            .navigationTitle("Search")
            .navigationDestination(for: AppInfo.self) { appInfo in
                AppDetailView(appInfo: appInfo)
            }
            .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: "App Store")
            .onSubmit(of: .search) {
                Task { await viewModel.search(term: searchText) }
            }
            .onChange(of: searchText) { _, newValue in
                if newValue.isEmpty {
                    viewModel.clearSearch()
                }
                viewModel.filterHistory(with: newValue)
            }
        }
    }

    // MARK: - Highlighted Text

    private func highlightedText(_ text: String, highlight: String) -> Text {
        guard !highlight.isEmpty,
              let range = text.range(of: highlight, options: .caseInsensitive) else {
            return Text(text).foregroundColor(.secondary)
        }

        let before = String(text[text.startIndex..<range.lowerBound])
        let match = String(text[range])
        let after = String(text[range.upperBound...])

        return Text(before).foregroundColor(.secondary)
            + Text(match).bold().foregroundColor(.primary)
            + Text(after).foregroundColor(.secondary)
    }
}

// MARK: - App List Row

struct AppListRow: View {
    let appInfo: AppInfo

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // App info header
            HStack(spacing: 12) {
                AsyncImage(url: URL(string: appInfo.artworkUrl100 ?? "")) { image in
                    image.resizable().scaledToFill()
                } placeholder: {
                    RoundedRectangle(cornerRadius: 12).fill(.quaternary)
                }
                .frame(width: 64, height: 64)
                .clipShape(RoundedRectangle(cornerRadius: 14))

                VStack(alignment: .leading, spacing: 4) {
                    Text(appInfo.trackName ?? "")
                        .font(.body)
                        .lineLimit(1)

                    Text(appInfo.genres?.first ?? "")
                        .font(.caption)
                        .foregroundStyle(.secondary)

                    HStack(spacing: 4) {
                        StarRatingView(rating: appInfo.averageUserRating ?? 0)
                        Text("\(appInfo.userRatingCount ?? 0)")
                            .font(.caption2)
                            .foregroundStyle(.secondary)
                    }
                }

                Spacer()

                Button("GET") {}
                    .buttonStyle(.bordered)
                    .controlSize(.small)
            }

            // Screenshots
            if let screenshots = appInfo.screenshotUrls, !screenshots.isEmpty {
                HStack(spacing: 8) {
                    ForEach(screenshots.prefix(3), id: \.self) { url in
                        AsyncImage(url: URL(string: url)) { image in
                            image.resizable().scaledToFill()
                        } placeholder: {
                            RoundedRectangle(cornerRadius: 8).fill(.quaternary)
                        }
                        .frame(height: 180)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                    }
                }
            }
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    SearchView()
}
