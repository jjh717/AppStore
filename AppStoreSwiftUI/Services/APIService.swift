//
//  APIService.swift
//  AppStoreSwiftUI
//
//  Created by jjh717
//

import Foundation

actor APIService {
    static let shared = APIService()
    private let baseURL = "https://itunes.apple.com"

    func searchApps(term: String) async throws -> [AppInfo] {
        var components = URLComponents(string: "\(baseURL)/search")!
        components.queryItems = [
            URLQueryItem(name: "term", value: term),
            URLQueryItem(name: "country", value: "kr"),
            URLQueryItem(name: "entity", value: "software"),
            URLQueryItem(name: "limit", value: "50"),
        ]

        guard let url = components.url else {
            throw URLError(.badURL)
        }

        let (data, _) = try await URLSession.shared.data(from: url)
        let response = try JSONDecoder().decode(AppInfoResponse.self, from: data)
        return response.results
    }
}
