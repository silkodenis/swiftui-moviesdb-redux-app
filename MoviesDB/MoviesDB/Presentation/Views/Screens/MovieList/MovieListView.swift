//
//  MoviesListView.swift
//  MoviesDB
//
//  Created by Denis Silko on 27.08.2024.
//

import SwiftUI

struct MovieListView<S: View, R: View>: View {
    let searchbar: () -> S
    let row: (Int) -> R
    
    let ids: [Int]
    let title: String
    
    let logout: Command
    let loadNextPage: Command?
    
    @State private var isLoading = false
    
    var body: some View {
        VStack {
            searchbar()
            
            List {
                ForEach(ids, id:\.self, content: row)
                loadingIndicator
            }
            .listStyle(.plain)
            .onChange(of: ids) { _ in isLoading = false }
            .gesture(DragGesture().onChanged { _ in
                    Keyboard.hide()
                }
            )
        }
        .padding()
        .navigationTitle(title)
        .navigationBarBackButtonHidden()
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {LogoutBarItem(action: {
            Keyboard.hide()
            logout()
        })}
    }
    
    @ViewBuilder
    private var loadingIndicator: some View {
        if let loadNextPage {
            HStack {
                Spacer()
                if isLoading {
                    ProgressView()
                }
                Spacer()
            }
            .onAppear {
                if !isLoading {
                    loadNextPage()
                    isLoading = true
                }
            }
            .listRowSeparator(.hidden)
        } else {
            EmptyView()
        }
    }
}

extension MovieListView: Equatable where S: Equatable, R: Equatable {
    static func == (lhs: MovieListView<S, R>, rhs: MovieListView<S, R>) -> Bool {
        lhs.ids == rhs.ids &&
        lhs.title == rhs.title
    }
}

#Preview {
    NavigationView {
        MovieListView(searchbar: {SearchbarView_Previews.previews},
                      row: { _ in MovieRowView_Previews.previews },
                      ids: Array(1...15),
                      title: "Trending Movies",
                      logout: nop,
                      loadNextPage: nop)
    }
}
