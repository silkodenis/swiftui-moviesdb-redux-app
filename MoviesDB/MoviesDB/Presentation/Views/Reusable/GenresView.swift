//
//  GenresView.swift
//  MoviesDB
//
//  Created by Denis Silko on 05.09.2024.
//

import SwiftUI

struct GenresView: View {
    let genres: [String]
    private static let step = 4
    
    var body: some View {
        VStack {
            let chunkedArray = stride(from: 0, to: genres.count, by: Self.step).map {
                Array(genres[$0..<min($0 + Self.step, genres.count)])
            }
            
            return ForEach(chunkedArray, id: \.self) { rows in
                HStack {
                    ForEach(rows, id: \.self) { text in
                        Text(text)
                            .padding(8)
                            .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.gray))
                            .lineLimit(1)
                    }
                }
            }
        }
    }
}

#Preview {
    GenresView(genres: ["Science Fiction", "Family", "Comedy", "Action", "Adventure", "Adventure", "Comedy"])
}
