//
//  MoviesService.swift
//  MoviesAPI
//
//  Created by Denis Silko on 09.04.2024.
//  Copyright © 2024 Denis Silko. All rights reserved.
//

import Foundation
import Combine
import CombineNetworking

protocol MoviesAPI {
    func authentication() -> AnyPublisher<TokenDTO, Error>
    func validation(username: String, password: String, token: String) -> AnyPublisher<TokenDTO, Error>
    func session(with token: String) -> AnyPublisher<SessionDTO, Error>
    func guestSession() -> AnyPublisher<SessionDTO, Error>
    func deleteSession(with id: String) -> AnyPublisher<SessionDTO, Error>
    func configuration() -> AnyPublisher<ConfigurationDTO, Error>
    func trending(page: Int) -> AnyPublisher<PageDTO<MovieDTO>, Error>
    func movieDetail(id: Int) -> AnyPublisher<MovieDetailDTO, Error>
    func search(query: String, page: Int) -> AnyPublisher<PageDTO<MovieDTO>, Error>
    func loadThumbnailPosters(paths: [Int: String]) -> AnyPublisher<[Int: Data], Never>
    func loadDetailPoster(path: String, id: Int) -> AnyPublisher<(Int, Data)?, Never>
    func signUpURL() -> AnyPublisher<URL, Never>
}

class DefaultMoviesAPI: MoviesAPI {
    typealias Endpoint = MoviesEndpoint
    
    private let client: HTTPClient
    private let builder: HTTPRequestBuilder<Endpoint>
    
    private static let signUpURL = URL(string: "https://www.themoviedb.org/signup")!
    private static let basePosterURL = URL(string: "https://image.tmdb.org/t/p")!
    private static let thumbnailPosterSize: PosterSize = .w154
    private static let detailPosterSize: PosterSize = .w500
    
    init(httpClient: HTTPClient, requestBuilder: HTTPRequestBuilder<Endpoint>) {
        self.client = httpClient
        self.builder = requestBuilder
    }
    
    func authentication() -> AnyPublisher<TokenDTO, Error> {
        builder.request(.authentication)
            .flatMap(client.executeJsonRequest)
            .eraseToAnyPublisher()
    }
    
    func validation(username: String, password: String, token: String) -> AnyPublisher<TokenDTO, Error> {
        builder.request(.validation, with: Login(username: username,
                                                 password: password,
                                            request_token: token))
        .flatMap(client.executeJsonRequest)
        .eraseToAnyPublisher()
    }
    
    func session(with token: String) -> AnyPublisher<SessionDTO, Error> {
        builder.request(.session, with: Token(request_token: token))
            .flatMap(client.executeJsonRequest)
            .eraseToAnyPublisher()
    }
    
    func guestSession() -> AnyPublisher<SessionDTO, Error> {
        builder.request(.guestSession)
            .flatMap(client.executeJsonRequest)
            .eraseToAnyPublisher()
    }
    
    func deleteSession(with id: String) -> AnyPublisher<SessionDTO, Error> {
        builder.request(.deleteSession, with: Session(session_id: id))
            .flatMap(client.executeJsonRequest)
            .eraseToAnyPublisher()
    }
    
    func configuration() -> AnyPublisher<ConfigurationDTO, Error> {
        builder.request(.configuration)
            .flatMap(client.executeJsonRequest)
            .eraseToAnyPublisher()
    }
    
    func trending(page: Int) -> AnyPublisher<PageDTO<MovieDTO>, Error> {
        builder.request(.trendingMovies(.week, page: page))
            .flatMap(client.executeJsonRequest)
            .eraseToAnyPublisher()
    }
    
    func movieDetail(id: Int) -> AnyPublisher<MovieDetailDTO, Error> {
        builder.request(.movieDetail(id: id))
            .flatMap(client.executeJsonRequest)
            .eraseToAnyPublisher()
    }
    
    func search(query: String, page: Int) -> AnyPublisher<PageDTO<MovieDTO>, Error> {
        builder.request(.search(query: query, page: page))
            .flatMap(client.executeJsonRequest)
            .eraseToAnyPublisher()
    }
    
    func signUpURL() -> AnyPublisher<URL, Never> {
        Just(Self.signUpURL)
            .eraseToAnyPublisher()
    }
    
    func loadThumbnailPosters(paths: [Int: String]) -> AnyPublisher<[Int: Data], Never> {
        let publishers = paths.map { (id, path) in
            loadPoster(path: path, id: id, size: Self.thumbnailPosterSize)
        }
        
        return Publishers.MergeMany(publishers)
            .compactMap { $0 }
            .collect()
            .map { Dictionary(uniqueKeysWithValues: $0)}
            .eraseToAnyPublisher()
    }
    
    func loadDetailPoster(path: String, id: Int) -> AnyPublisher<(Int, Data)?, Never> {
        return loadPoster(path: path, id: id, size: Self.detailPosterSize)
    }
    
    // MARK: - Private
    
    private func loadPoster(path: String, id: Int, size: PosterSize) -> AnyPublisher<(Int, Data)?, Never> {
        let url = Self.basePosterURL
            .appendingPathComponent(size.rawValue)
            .appendingPathComponent(path)
            
        return Just(URLRequest(url: url))
            .flatMap { [unowned self] request in
                client.executeDataRequest(request)
                    .map { data in (id, data) }
                    .catch { _ in Just(nil) }
                    .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
}

// MARK: - fileprivate inner types

fileprivate extension DefaultMoviesAPI {
    struct Login: Codable {
        let username: String
        let password: String
        let request_token: String
    }
    
    struct Token: Codable {
        let request_token: String
    }
    
    struct Session: Codable {
        let session_id: String
    }
    
    enum PosterSize: String {
        case w92
        case w154
        case w185
        case w342
        case w500
        case w780
        case original
    }
}
