//
//  SearchViewModel.swift
//  AppStoreSwiftUI
//
//  Created by jjh717
//

import SwiftUI

@Observable
final class SearchViewModel {

    // MARK: - State

    var searchResults: [AppInfo] = []
    var searchHistory: [String] = []
    var filteredHistory: [String] = []
    var isLoading = false
    var searchText = ""
    var isSearching = false
    var errorMessage: String?

    private let historyKey = "searchHistory"

    init() {
        loadHistory()
    }

    // MARK: - Search

    func search(term: String) async {
        guard !term.trimmingCharacters(in: .whitespaces).isEmpty else { return }

        isLoading = true
        errorMessage = nil
        addToHistory(term)

        do {
            let results = try await APIService.shared.searchApps(term: term)
            await MainActor.run {
                searchResults = results
                isLoading = false
                isSearching = true
            }
        } catch {
            await MainActor.run {
                errorMessage = error.localizedDescription
                isLoading = false
            }
        }
    }

    // MARK: - History

    func filterHistory(with text: String) {
        if text.isEmpty {
            filteredHistory = searchHistory
        } else {
            filteredHistory = searchHistory.filter {
                $0.localizedCaseInsensitiveContains(text)
            }
        }
    }

    func clearSearch() {
        searchResults = []
        isSearching = false
    }

    private func addToHistory(_ term: String) {
        searchHistory.removeAll { $0 == term }
        searchHistory.insert(term, at: 0)
        if searchHistory.count > 20 { searchHistory = Array(searchHistory.prefix(20)) }
        saveHistory()
    }

    private func loadHistory() {
        searchHistory = UserDefaults.standard.stringArray(forKey: historyKey) ?? []
        filteredHistory = searchHistory
    }

    private func saveHistory() {
        UserDefaults.standard.set(searchHistory, forKey: historyKey)
    }
}
