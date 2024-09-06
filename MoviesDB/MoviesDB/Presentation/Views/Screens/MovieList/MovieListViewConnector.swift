//
//  MoviesListViewConnector.swift
//  MoviesDB
//
//  Created by Denis Silko on 29.08.2024.
//

import SwiftUI
import Core

struct MovieListViewConnector: ViewConnector {
    @EnvironmentObject var coordinator: Coordinator
    
    func map(graph: Graph) -> some View {
        MovieListView(searchbar: {SearchbarViewConnector()},
                      row: {MovieRowViewConnector(id: .init($0))},
                      ids: graph.movieListFlow.ids.map(\.value),
                      title: graph.movieListFlow.title,
                      logout: graph.loginFlow.logout,
                      loadNextPage: graph.movieListFlow.loadNextPage)
    }
    
    func feedback(action: any AppAction) {
        switch action {
        case is Logout:
            coordinator.popToRoot()
            
        case let action as SelectMovieRow:
            coordinator.present(.movieDetail(id: action.id))
            
        default:
            break
        }
    }
}
