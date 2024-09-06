//
//  MoviesEndpoint.swift
//  MoviesAPI
//
//  Created by Denis Silko on 12.04.2024.
//

import Foundation
import CombineNetworking

enum MoviesEndpoint {
    case authentication
    case validation
    case session
    case guestSession
    case deleteSession
    case configuration
    case trendingMovies(TimeWindow, page: Int = 1)
    case search(query: String, page: Int = 1)
    case movieDetail(id: Int)

    private static let apiKey = "7991ddf0e789dc96d90ed191a4fda7ff"
    private static let baseURL = URL(string: "https://api.themoviedb.org/3")!
}

extension MoviesEndpoint: HTTPEndpoint {
    var baseURL: URL {
        return Self.baseURL
    }
    
    var path: String {
        switch self {
        case .authentication: return "authentication/token/new"
        case .validation: return "authentication/token/validate_with_login"
        case .session: return "authentication/session/new"
        case .guestSession: return "authentication/guest_session/new"
        case .deleteSession: return "authentication/session"
        case .configuration: return "configuration"
        case .trendingMovies(let timeWindow, _): return "trending/movie/\(timeWindow.rawValue)"
        case .movieDetail(let id): return "movie/\(id)"
        case .search: return "search/movie"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .validation, .session:
            return .post
        case .deleteSession:
            return .delete
        default:
            return .get
        }
    }
    
    var headers: [String: String]? {
        var headers = ["Accept": "application/json"]
        switch self {
        case .validation, .session, .deleteSession:
            headers["Content-Type"] = "application/json"
        default: break
        }
        return headers
    }
    
    var parameters: [String: Any]? {
        var parameters = ["api_key": Self.apiKey]
        
        switch self {
        case .search(let query, let page):
            parameters["query"] = query
            parameters["page"] = String(page)
            
        case .trendingMovies(_, let page):
            parameters["page"] = String(page)
            
        default:
            break
        }
        
        return parameters
    }
    
    var timeout: TimeInterval {
        return 15
    }
}

// MARK: - Inner Types

extension MoviesEndpoint {
    enum TimeWindow: String {
        case day
        case week
    }
}
