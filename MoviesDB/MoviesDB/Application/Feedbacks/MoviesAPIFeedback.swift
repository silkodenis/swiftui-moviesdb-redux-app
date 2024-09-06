//
//  MoviesAPIFeedback.swift
//  MoviesDB
//
//  Created by Denis Silko on 15.08.2024.
//

import Foundation
import Combine
import CombineNetworking
import Core

struct MoviesAPIFeedback {
    
    private static let invalidCredentialsCode = 401
    
    // MARK: - Authenticating
    
    static func authenticating(api: MoviesAPI) -> Feedback {
        Feedback { state in
            guard case .authenticating = state.loginFlow,
                  case .inProgress = state.loginStatus else {
                return NoEffect().eraseToAnyPublisher()
            }
            
            return api.authentication()
                .map { ReceiveToken($0.asCoreToken)}
                .catch { _ in Just(TokenRequestFailed()) }
                .eraseToAnyPublisher()
        }
    }
    
    // MARK: - Validating
    
    static func validatingCredentials(api: MoviesAPI) -> Feedback {
        Feedback { state in
            guard case .inProgress = state.loginStatus,
                  case .validating(let token) = state.loginFlow,
                  let credentials = state.loginForm.credentials else {
                return NoEffect().eraseToAnyPublisher()
            }
            
            return api.validation(username: credentials.username.string,
                                  password: credentials.password.string,
                                  token: token.string)
            .map { _ in TokenValidated(token) }
            .catch { error in
                let action: AppAction
                
                if case let .invalidResponse(details) = error as? HTTPClientError,
                   details.statusCode == Self.invalidCredentialsCode {
                    action = InvalidCredentials()
                } else {
                    action = TokenValidationFailed()
                }
                
                return Just(action)
            }
            .eraseToAnyPublisher()
        }
    }
    
    // MARK: - User Session
    
    static func creatingUserSession(api: MoviesAPI) -> Feedback {
        Feedback { state in
            guard case .inProgress = state.loginStatus,
                  case .creatingUserSession(let token) = state.loginFlow else {
                return NoEffect().eraseToAnyPublisher()
            }
            
            return api.session(with: token.string)
                .map { session in
                    guard session.success, let id = session.session_id else {
                        return SessionRequestFailed()
                    }
                    
                    return ReceiveUserSession(.init(token: token, id: .init(id)))
                }
                .catch { _ in Just(SessionRequestFailed()) }
                .eraseToAnyPublisher()
        }
    }
    
    // MARK: - Guest Session
    
    static func creatingGuestSession(api: MoviesAPI) -> Feedback {
        Feedback { state in
            guard case .inProgress = state.loginStatus,
                  case .creatingGuestSession = state.loginFlow else {
                return NoEffect().eraseToAnyPublisher()
            }
            
            return api.guestSession()
                .map { session in
                    guard session.success, let id = session.guest_session_id else {
                        return SessionRequestFailed()
                    }
                    
                    return ReceiveGuestSession(.init(id: .init(id)))
                }
                .catch { _ in Just(SessionRequestFailed()) }
                .eraseToAnyPublisher()
        }
    }
    
    // MARK: - Movie Page
    
    static func loadingMoviePage(api: MoviesAPI) -> Feedback {
        Feedback { state in
            guard case .success = state.loginStatus,
                  state.movieList.canLoad else {
                return NoEffect().eraseToAnyPublisher()
            }
            
            let page = state.movieList.nextPage
            
            return api.trending(page: page)
                .map(\.asCorePage)
                .map(ReceiveMoviePage.init)
                .catch { _ in Just(PageRequestFailed()) }
                .eraseToAnyPublisher()
        }
    }
    
    // MARK: - Search Page
    
    static func loadingSearchPage(api: MoviesAPI) -> Feedback {
        Feedback { state in
            let searchbar = state.searchbar
            
            guard case .success = state.loginStatus,
                  searchbar.canLoad else {
                return NoEffect().eraseToAnyPublisher()
            }
            
            let query = searchbar.query
            let page = searchbar.nextPage
            
            return api.search(query: query, page: page)
                .map(\.asCorePage)
                .map(ReceiveSearchPage.init)
                .catch {_ in Just(SearchPageRequestFailed()) }
                .eraseToAnyPublisher()
        }
    }
    
    // MARK: - Movie Details
    
    static func loadingMovieDetail(api: MoviesAPI) -> Feedback {
        Feedback(effects: { state in
            guard case .success = state.loginStatus,
                  let id = state.allMovieDetails.selectedMovie,
                  !state.allMovieDetails.byId.keys.contains(id) else {
                return NoEffect().eraseToAnyPublisher()
            }
            
            return api.movieDetail(id: id.value)
                .map(\.asCoreMovieDetail)
                .map(ReceiveMovieDetail.init)
                .catch { _ in Just(MovieDetailRequestFailed()) }
                .eraseToAnyPublisher()
        }, preventDuplicate: false)
    }
    
    // MARK: - Posters
    
    static func loadingDetailPoster(api: MoviesAPI) -> Feedback {
        Feedback(effects: { state in
            let details = state.allMovieDetails.byId
            let posters = state.allPosters.details
            
            let ids = details.keys.filter({ posters[$0] == nil })
            
            guard case .success = state.loginStatus,
                  let id = ids.first,
                  let path = details[id]?.posterPath else {
                return NoEffect().eraseToAnyPublisher()
            }
            
            return api.loadDetailPoster(path: path, id: id.value)
                .map { result in
                    if let (id, data) = result {
                        let poster = Poster(data: data, movie: .init(id))
                        return ReceiveDetailPoster(poster: poster)
                    } else {
                        return DetailPosterRequestFailed()
                    }
                }
                .eraseToAnyPublisher()
        }, preventDuplicate: false)
    }
    
    static func loadingThumbnailPosters(api: MoviesAPI) -> Feedback {
        Feedback(effects: { state in
            let movies = state.allMovies.byId
            let thumbnails = state.allPosters.thumbnails
            
            guard case .success = state.loginStatus,
                  movies.count > thumbnails.count else {
                return NoEffect().eraseToAnyPublisher()
            }
            
            let existingIds = Set(thumbnails.keys.map { $0 })
            let posterPaths: [Int: String] = movies.compactMapValues { movie in
                guard !existingIds.contains(movie.id) else {
                    return nil
                }
                
                return movie.posterPath
            }.reduce(into: [:]) { result, pair in
                result[pair.key.value] = pair.value
            }
            
            guard posterPaths.count > 0 else {
                return NoEffect().eraseToAnyPublisher()
            }
            
            return api.loadThumbnailPosters(paths: posterPaths)
                .map { posters in
                    return ReceiveThumbnailPosters(
                        posters: posters.reduce(into: [:]) { result, element in
                            let (id, data) = element
                            let movieId = Movie.Id(id)
                            result[movieId] = Poster(data: data, movie: movieId)
                        }
                    )
                }
                .eraseToAnyPublisher()
        }, preventDuplicate: false)
    }
    
    // MARK: - Configuration

    static func receivingSignUpURL(api: MoviesAPI) -> Feedback {
        Feedback { state in
            guard state.signUpFlow.url == nil else {
                return NoEffect().eraseToAnyPublisher()
            }
            
            return api.signUpURL()
                .map(ReceiveSignUpURL.init)
                .eraseToAnyPublisher()
        }
    }
    
    static func deletingUserSession(api: MoviesAPI) -> Feedback {
        Feedback { state in
            guard case .idle = state.loginStatus,
                  case let .user(session) = state.session else {
                return NoEffect().eraseToAnyPublisher()
            }
            
            return api.deleteSession(with: session.id.value)
                .map { _ in DeleteUserSession(session.id) }
                .catch { _ in Just(DeleteUserSessionRequestFailed()) }
                .eraseToAnyPublisher()
        }
    }
}

// MARK: - DTOs to Core Models

fileprivate extension TokenDTO {
    var asCoreToken: Core.Token {
        .init(self.request_token)
    }
}

fileprivate extension MovieDTO {
    var asCoreMovie: Core.Movie {
        .init(id: .init(self.id),
              title: self.title,
              description: self.overview,
              posterPath: self.poster_path)
    }
}

fileprivate extension MovieDetailDTO {
    var asCoreMovieDetail: Core.MovieDetail {
        .init(movie: .init(self.id),
              title: self.title,
              runtime: self.runtime,
              genres: self.genres.map(\.name),
              overview: self.overview,
              languages: self.spoken_languages.map(\.name),
              countries: self.production_countries.map(\.name),
              posterPath: self.poster_path,
              voteAverage: self.vote_average,
              releaseDate: self.release_date)
    }
}

fileprivate extension PageDTO<MovieDTO> {
    var asCorePage: Core.MoviePage {
        .init(movies: self.results.map(\.asCoreMovie),
              page: self.page,
              totalPages: self.total_pages)
    }
}
