//
//  SearchbarView.swift
//  MoviesDB
//
//  Created by Denis Silko on 29.08.2024.
//

import SwiftUI

struct SearchbarView: View {
    @Binding var query: String
    let clear: Command
    
    var body: some View {
        HStack {
            TextField("Search...", text: $query)
                .padding(7)
                .padding(.horizontal, 25)
                .background(.gray.opacity(0.1))
                .cornerRadius(8)
                .overlay(
                    HStack {
                        magnifyingglass
                        
                        if !query.isEmpty {
                            clearButton
                        }
                    })
                .textFieldStyle(.plain)
        }
    }
    
    var magnifyingglass: some View {
        Image(systemName: "magnifyingglass")
            .foregroundColor(.gray)
            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
            .padding(.leading, 8)
    }
    
    var clearButton: some View {
        Button(action: {
            Keyboard.hide()
            clear()
        }) {
            Image(systemName: "multiply.circle.fill")
                .foregroundColor(.gray)
                .padding(.trailing, 8)
        }
    }
}

extension SearchbarView: Equatable {
    static func == (lhs: SearchbarView, rhs: SearchbarView) -> Bool {
        lhs.query == rhs.query
    }
}

// MARK: - Preview

struct SearchbarView_Previews: PreviewProvider {
    static var previews: some View {
        SearchbarView(query: State(initialValue: "").projectedValue,
                      clear: nop)
    }
}
