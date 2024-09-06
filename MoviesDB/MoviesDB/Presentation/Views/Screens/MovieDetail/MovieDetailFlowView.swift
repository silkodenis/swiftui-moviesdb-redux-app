//
//  MovieDetailFlowView.swift
//  MoviesDB
//
//  Created by Denis Silko on 05.09.2024.
//

import SwiftUI
 
struct MovieDetailFlowView<P: View, C: View>: View {
    let progress: () -> P
    let content: () -> C
    let isLoading: Bool
    
    var body: some View {
        if isLoading {
            progress()
        } else {
            content()
        }
    }
}

#Preview {
    MovieDetailFlowView(progress: {ProgressView()},
                        content: {MovieDetailView_Previews.previews},
                        isLoading: false)
}
