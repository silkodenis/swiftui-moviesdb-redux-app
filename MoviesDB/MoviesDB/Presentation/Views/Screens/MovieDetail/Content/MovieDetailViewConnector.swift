//
//  MovieDetailViewConnector.swift
//  MoviesDB
//
//  Created by Denis Silko on 02.09.2024.
//

import SwiftUI
import Core

struct MovieDetailViewConnector: ViewConnector {
    @EnvironmentObject var coordinator: Coordinator
    
    let id: Movie.Id
    
    func map(graph: Graph) -> some View {
        let movie = graph.movie(id: id)
        let details = graph.movieDetail(id: id)
        
        return MovieDetailView(title: movie.title,
                               runtime: details.runtime,
                               genres: details.genres,
                               rating: details.rating,
                               overview: details.overview,
                               releaseAt: details.releaseAt,
                               countries: details.countries,
                               image: details.posterData.flatMap(UIImage.init),
                               close: {coordinator.dismiss()})
    }
}
