//
//  AppConfigurator.swift
//  MoviesDB
//
//  Created by Denis Silko on 15.08.2024.
//

import Foundation
import CombineNetworking

class AppConfigurator {
    let moviesAPI: MoviesAPI
    let feedbacks: [Feedback]
    
    init() {
        let httpClient = HTTPClient(jsonDecoder: JSONDecoder(), session: URLSession.shared)
        let requestBuilder = HTTPRequestBuilder<MoviesEndpoint>(jsonEncoder: JSONEncoder())
        self.moviesAPI = DefaultMoviesAPI(httpClient: httpClient, requestBuilder: requestBuilder)
        
        self.feedbacks = [
            MoviesAPIFeedback.authenticating(api: moviesAPI),
            MoviesAPIFeedback.validatingCredentials(api: moviesAPI),
            MoviesAPIFeedback.creatingUserSession(api: moviesAPI),
            MoviesAPIFeedback.creatingGuestSession(api: moviesAPI),
            MoviesAPIFeedback.receivingSignUpURL(api: moviesAPI),
            MoviesAPIFeedback.loadingMoviePage(api: moviesAPI),
            MoviesAPIFeedback.loadingMovieDetail(api: moviesAPI),
            MoviesAPIFeedback.loadingDetailPoster(api: moviesAPI),
            MoviesAPIFeedback.loadingThumbnailPosters(api: moviesAPI),
            MoviesAPIFeedback.loadingSearchPage(api: moviesAPI),
            MoviesAPIFeedback.deletingUserSession(api: moviesAPI)
        ]
    }
}
