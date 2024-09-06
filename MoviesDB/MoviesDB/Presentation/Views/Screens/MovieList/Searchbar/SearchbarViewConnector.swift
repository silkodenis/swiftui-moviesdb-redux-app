//
//  SearchbarViewConnector.swift
//  MoviesDB
//
//  Created by Denis Silko on 29.08.2024.
//

import SwiftUI

struct SearchbarViewConnector: ViewConnector {
    func map(graph: Graph) -> some View {
        SearchbarView(query: Binding(get: {graph.searchbar.query},
                                     set: {graph.searchbar.query = $0}),
                      clear: graph.searchbar.clear)
    }
}

