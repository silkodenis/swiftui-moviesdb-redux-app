//
//  File.swift
//  
//
//  Created by Denis Silko on 09.08.2024.
//

import Foundation

public protocol AppAction {}

// MARK: - Search

public struct ClearSearchQuery: AppAction {
    public init() {}
}

public struct UpdateSearchQuery: AppAction {
    public init(_ query: String) {
        self.query = query
    }
    
    public let query: String
}

public struct ReceiveSearchPage: AppAction {
    public init(_ page: MoviePage) {
        self.page = page
    }
    
    public let page: MoviePage
}

public struct SearchPageRequestFailed: AppAction {
    public init() {}
}

public struct RequestNextSearchPage: AppAction {
    public init() {}
}

// MARK: - Sign In

public struct ReceiveSignUpURL: AppAction {
    public init(url: URL) {
        self.url = url
    }
    
    public let url: URL
}

// MARK: - Login

public struct Login: AppAction {
    public init() {}
}

public struct EnterAsGuest: AppAction {
    public init() {}
}

public struct Logout: AppAction {
    public init() {}
}

public struct RetryLoginFlow: AppAction {
    public init() {}
}

// MARK: - Login Form

public struct UpdateUsername: AppAction {
    public init(_ username: String) {
        self.username = username
    }
    
    public let username: String
}

public struct UpdatePassword: AppAction {
    public init(_ password: String) {
        self.password = password
    }
    
    public let password: String
}

public struct InvalidCredentials: AppAction {
    public init() {}
}

// MARK: - Authentication, Token

public struct ReceiveToken: AppAction {
    public let token: Token
    
    public init(_ token: Token) {
        self.token = token
    }
}

public struct TokenRequestFailed: AppAction {
    public init() {}
}

public struct TokenValidated: AppAction {
    public let token: Token
    
    public init(_ token: Token) {
        self.token = token
    }
}

public struct TokenValidationFailed: AppAction {
    public init() {}
}

// MARK: - Session

public struct ReceiveUserSession: AppAction {
    public init(_ session: Session.User) {
        self.session = session
    }
    
    public let session: Session.User
}

public struct ReceiveGuestSession: AppAction {
    public init(_ session: Session.Guest) {
        self.session = session
    }
    
    public let session: Session.Guest
}

public struct SessionRequestFailed: AppAction {
    public init() {}
}

public struct DeleteUserSession: AppAction {
    public init(_ id: Session.Id) {
        self.id = id
    }
    
    public let id: Session.Id
}

public struct DeleteUserSessionRequestFailed: AppAction {
    public init() {}
}

// MARK: - Pages, Movies

public struct ReceiveMoviePage: AppAction {
    public init(_ page: MoviePage) {
        self.page = page
    }
    
    public let page: MoviePage
}

public struct PageRequestFailed: AppAction {
    public init() {}
}

public struct RequestNextMoviePage: AppAction {
    public init() {}
}

// MARK: - Movie Details

public struct ReceiveMovieDetail: AppAction {
    public init(_ details: MovieDetail) {
        self.details = details
    }
    
    public let details: MovieDetail
}

public struct MovieDetailRequestFailed: AppAction {
    public init() {}
}

// MARK: - Details

public struct SelectMovieRow: AppAction {
    public init(_ id: Movie.Id) {
        self.id = id
    }
    
    public let id: Movie.Id
}

// MARK: - Posters

public struct ReceiveThumbnailPosters: AppAction {
    public let posters: [Movie.Id : Poster]
    
    public init(posters: [Movie.Id : Poster]) {
        self.posters = posters
    }
}

public struct ReceiveDetailPoster: AppAction {
    public let poster: Poster
    
    public init(poster: Poster) {
        self.poster = poster
    }
}

public struct DetailPosterRequestFailed: AppAction {
    public init() {}
}

