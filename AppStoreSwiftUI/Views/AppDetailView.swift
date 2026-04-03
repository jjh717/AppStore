//
//  AppDetailView.swift
//  AppStoreSwiftUI
//
//  Created by jjh717
//

import SwiftUI

struct AppDetailView: View {
    let appInfo: AppInfo

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                titleSection
                ratingSection
                screenshotSection
                descriptionSection
                infoSection
            }
            .padding()
        }
        .navigationBarTitleDisplayMode(.inline)
    }

    // MARK: - Title Section

    private var titleSection: some View {
        HStack(spacing: 16) {
            AsyncImage(url: URL(string: appInfo.artworkUrl512 ?? "")) { image in
                image.resizable().scaledToFill()
            } placeholder: {
                RoundedRectangle(cornerRadius: 20).fill(.quaternary)
            }
            .frame(width: 120, height: 120)
            .clipShape(RoundedRectangle(cornerRadius: 26))

            VStack(alignment: .leading, spacing: 6) {
                Text(appInfo.trackName ?? "")
                    .font(.title2.bold())
                    .lineLimit(2)

                Text(appInfo.artistName ?? "")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)

                Text(appInfo.genres?.first ?? "")
                    .font(.caption)
                    .foregroundStyle(.secondary)

                HStack {
                    Button("GET") {}
                        .buttonStyle(.borderedProminent)
                        .controlSize(.small)
                }
            }
        }
    }

    // MARK: - Rating Section

    private var ratingSection: some View {
        HStack(spacing: 20) {
            VStack {
                Text(String(format: "%.1f", appInfo.averageUserRating ?? 0))
                    .font(.title.bold())
                StarRatingView(rating: appInfo.averageUserRating ?? 0)
                Text("\(appInfo.userRatingCount ?? 0) ratings")
                    .font(.caption2)
                    .foregroundStyle(.secondary)
            }

            Divider().frame(height: 50)

            VStack {
                Text(appInfo.trackContentRating ?? "")
                    .font(.title2.bold())
                Text("Age")
                    .font(.caption2)
                    .foregroundStyle(.secondary)
            }

            Divider().frame(height: 50)

            VStack {
                Text(appInfo.primaryGenreName ?? "")
                    .font(.caption.bold())
                Text("Category")
                    .font(.caption2)
                    .foregroundStyle(.secondary)
            }
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(.quaternary.opacity(0.5), in: RoundedRectangle(cornerRadius: 12))
    }

    // MARK: - Screenshot Section

    private var screenshotSection: some View {
        Group {
            if let screenshots = appInfo.screenshotUrls, !screenshots.isEmpty {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Preview")
                        .font(.headline)

                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 10) {
                            ForEach(screenshots, id: \.self) { url in
                                AsyncImage(url: URL(string: url)) { image in
                                    image.resizable().scaledToFit()
                                } placeholder: {
                                    RoundedRectangle(cornerRadius: 12).fill(.quaternary)
                                        .frame(width: 230, height: 420)
                                }
                                .frame(height: 420)
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                            }
                        }
                    }
                }
            }
        }
    }

    // MARK: - Description Section

    private var descriptionSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            if let releaseNotes = appInfo.releaseNotes {
                Text("What's New")
                    .font(.headline)
                Text("Version \(appInfo.version ?? "")")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                Text(releaseNotes)
                    .font(.subheadline)
                    .lineLimit(3)
                Divider()
            }

            if let description = appInfo.description {
                Text("Description")
                    .font(.headline)
                Text(description)
                    .font(.subheadline)
                    .lineLimit(5)
            }
        }
    }

    // MARK: - Info Section

    private var infoSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Information")
                .font(.headline)

            infoRow("Provider", appInfo.sellerName ?? "-")
            infoRow("Category", appInfo.primaryGenreName ?? "-")
            infoRow("Age Rating", appInfo.trackContentRating ?? "-")

            if let fileSize = appInfo.fileSizeBytes, let bytes = Int(fileSize) {
                let mb = Double(bytes) / 1_048_576.0
                infoRow("Size", String(format: "%.1f MB", mb))
            }

            if let languages = appInfo.languageCodesISO2A {
                infoRow("Languages", "\(languages.count) languages")
            }
        }
    }

    private func infoRow(_ title: String, _ value: String) -> some View {
        HStack {
            Text(title)
                .font(.subheadline)
                .foregroundStyle(.secondary)
            Spacer()
            Text(value)
                .font(.subheadline)
        }
    }
}
