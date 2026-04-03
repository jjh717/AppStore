//
//  UserEndpoint.swift
//  AppStore
//
//  Created by jjh717
//

import Foundation

public enum RequestType: String {
    case GET, POST
}

protocol APIConfiguration {
    var method: RequestType { get }
    var path: String { get }
    var parameters: [String : Any] { get }
}

enum UserEndpoint: APIConfiguration {
    case search(term: String)
    
    var method: RequestType {
        switch self {
            case .search:
                return .GET
        }
    }

    var path: String {
        switch self {
        case .search:
            return "search"
        }
    }
    
    var parameters: [String : Any] {
        switch self {
        case .search(let term):
            var parameters = [String : Any]()
            parameters["term"] = term
            parameters["country"] = "kr"
            parameters["entity"] = "software"
            parameters["limit"] = "200"
            return parameters
        }
    }
    
    func asURLRequest() -> URLRequest {
        guard let baseURL = URL(string: APIUrl.baseURL) else { fatalError("url error") }
        
        guard var components = URLComponents(url: baseURL.appendingPathComponent(path), resolvingAgainstBaseURL: false) else {
            fatalError("Unable to create URL components")
        }

        components.queryItems = parameters.map {
            URLQueryItem(name: String($0), value: "\($1)")
        }

        guard let url = components.url else {
            fatalError("Could not get url")
        }

        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        return request
    }
}
