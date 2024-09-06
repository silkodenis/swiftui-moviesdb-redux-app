//
//  MovieDetailView.swift
//  MoviesDB
//
//  Created by Denis Silko on 02.09.2024.
//

import SwiftUI

struct MovieDetailView: View {
    let title: String
    let runtime: Int?
    let genres: [String]
    let rating: Double?
    let overview: String?
    let releaseAt: String?
    let countries: [String]?
    let image: UIImage?
    let close: Command
    
    var body: some View {
        ScrollView {
            VStack(spacing: Constants.Layout.verticalSpacing) {
                posterView
                genresView
                Divider()
                ratingView
                Divider()
                descriptionView
                Divider()
                footerView
                Divider()
            }
        }
        .navigationTitle(title)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {BarItem(title: "Close", action: close)}
    }
    
    // MARK: -
    
    private var footerView: some View {
        HStack {
            Text(releaseAt ?? "")
            Divider()
            Text(countries?.first ?? "")
            Divider()
            Text(Formatter.duration(from: runtime))
        }
        .font(.subheadline)
    }
    
    @ViewBuilder
    private var posterView: some View {
        if let image {
            Image(uiImage: image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .cornerRadius(8)
                .shadow(radius: 4)
        } else {
            Image(systemName: "photo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundColor(.gray)
                .background(Color.gray.opacity(0.1))
                .cornerRadius(8)
        }
    }
    
    private var genresView: some View {
        GenresView(genres: genres)
    }
    
    @ViewBuilder
    private var ratingView: some View {
        if let rating {
            RatingView(rating: rating)
        } else {
            Text("No Rating")
                .font(.body)
        }
    }
    
    private var descriptionView: some View {
        overview.map {
            Text($0)
                .font(.body)
                .padding(.horizontal)
        }
    }
}

// MARK: - Preview

struct MovieDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            MovieDetailView(title: "Longlegs",
                            runtime: 125,
                            genres: ["Science Fiction", "Family", "Comedy", "Action", "Adventure", "Adventure"],
                            rating: 8.434,
                            overview: "FBI Agent Lee Harker is assigned to an unsolved serial killer case that takes an unexpected turn, revealing evidence of the occult. Harker discovers a personal connection to the killer and must stop him before he strikes again.",
                            releaseAt: "1989-05-05",
                            countries: ["English"],
                            image: nil,
                            close: nop)
        }
    }
}



