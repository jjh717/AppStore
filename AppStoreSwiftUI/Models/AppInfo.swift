//
//  AppInfo.swift
//  AppStoreSwiftUI
//
//  Created by jjh717
//

import Foundation

struct AppInfoResponse: Codable {
    let resultCount: Int
    let results: [AppInfo]
}

struct AppInfo: Codable, Identifiable, Hashable {
    var id: Int { trackId ?? UUID().hashValue }

    let trackId: Int?
    let trackName: String?
    let artistName: String?
    let artworkUrl100: String?
    let artworkUrl512: String?
    let screenshotUrls: [String]?
    let ipadScreenshotUrls: [String]?
    let description: String?
    let releaseNotes: String?
    let version: String?
    let currentVersionReleaseDate: String?
    let averageUserRating: Double?
    let userRatingCount: Int?
    let trackContentRating: String?
    let genres: [String]?
    let primaryGenreName: String?
    let sellerName: String?
    let sellerUrl: String?
    let languageCodesISO2A: [String]?
    let fileSizeBytes: String?
    let minimumOsVersion: String?
    let supportedDevices: [String]?

    func hash(into hasher: inout Hasher) {
        hasher.combine(trackId)
    }

    static func == (lhs: AppInfo, rhs: AppInfo) -> Bool {
        lhs.trackId == rhs.trackId
    }
}
