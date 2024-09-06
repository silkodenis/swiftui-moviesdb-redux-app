//
//  MovieDetailFlowViewConnector.swift
//  MoviesDB
//
//  Created by Denis Silko on 05.09.2024.
//

import SwiftUI
import Core

struct MovieDetailFlowViewConnector: ViewConnector {
    let id: Movie.Id
    
    func map(graph: Graph) -> some View {
        let details = graph.movieDetail(id: id)
        
        return MovieDetailFlowView(progress: {ProgressView()},
                                   content: {MovieDetailViewConnector(id: id)},
                                   isLoading: details.isLoading)
    }
}
