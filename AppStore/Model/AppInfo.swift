//
//  AppInfo.swift
//  AppStore
//
//  Created by Paul Jang on 2021/03/19.
//

import Foundation

struct AppInfo: Codable {
    let advisories: [String]?
    let appletvScreenshotUrls: [String]?
    let artistId: Int?
    let artistName: String?
    let artistViewUrl: String?
    let artworkUrl100: String?
    let artworkUrl512: String?
    let artworkUrl60: String?
    let averageUserRating: Double?
    let averageUserRatingForCurrentVersion: Double?
    let bundleId: String?
    let contentAdvisoryRating: String?
    let currency: String?
    let currentVersionReleaseDate: String?
    let description: String?
    let features: [String]?
    let fileSizeBytes: String?
    let formattedPrice: String?
    let genreIds: [String]?
    let genres: [String]?
    let ipadScreenshotUrls: [String]?
    let isGameCenterEnabled: Bool?
    let isVppDeviceBasedLicensingEnabled: Bool?
    let kind: String?
    let languageCodesISO2A: [String]?
    let minimumOsVersion: String?
    let price: Double?
    let primaryGenreId: Int?
    let primaryGenreName: String?
    let releaseDate: String?
    let releaseNotes: String?
    let screenshotUrls: [String]?
    let sellerName: String?
    let sellerUrl: String?
    let supportedDevices: [String]?
    let trackCensoredName: String?
    let trackContentRating: String?
    let trackId: Int?
    let trackName: String?
    let trackViewUrl: String?
    let userRatingCount: Int?
    let userRatingCountForCurrentVersion: Int?
    let version: String?
    let wrapperType: String?
    
//    var subTitle: String = ""
    
    private enum CodingKeys: String, CodingKey {
        case advisories
        case appletvScreenshotUrls
        case artistId
        case artistName
        case artistViewUrl
        case artworkUrl100
        case artworkUrl512
        case artworkUrl60
        case averageUserRating
        case averageUserRatingForCurrentVersion
        case bundleId
        case contentAdvisoryRating
        case currency
        case currentVersionReleaseDate
        case description
        case features
        case fileSizeBytes
        case formattedPrice
        case genreIds
        case genres
        case ipadScreenshotUrls
        case isGameCenterEnabled
        case isVppDeviceBasedLicensingEnabled
        case kind
        case languageCodesISO2A
        case minimumOsVersion
        case price
        case primaryGenreId
        case primaryGenreName
        case releaseDate
        case releaseNotes
        case screenshotUrls
        case sellerName
        case sellerUrl
        case supportedDevices
        case trackCensoredName
        case trackContentRating
        case trackId
        case trackName
        case trackViewUrl
        case userRatingCount
        case userRatingCountForCurrentVersion
        case version
        case wrapperType
    }
}

struct AppInfoDict: Codable {
    let resultCount: Int
    var results: [AppInfo]
    
    private enum CodingKeys: String, CodingKey {
        case resultCount
        case results
    }
}
