//
//  MovieRowViewConnector.swift
//  MoviesDB
//
//  Created by Denis Silko on 30.08.2024.
//

import SwiftUI
import Core

struct MovieRowViewConnector: ViewConnector {
    let id: Movie.Id
    
    func map(graph: Graph) -> some View {
        let movie = graph.movie(id: id)

        return MovieRowView(title: movie.title,
                            description: movie.description,
                            image: movie.posterData.flatMap(UIImage.init),
                            select: movie.select)
    }
}
