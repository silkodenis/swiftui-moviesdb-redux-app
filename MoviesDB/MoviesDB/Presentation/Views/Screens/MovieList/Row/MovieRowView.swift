//
//  MovieRowView.swift
//  MoviesDB
//
//  Created by Denis Silko on 30.08.2024.
//

import SwiftUI

struct MovieRowView: View {
    let title: String
    let description: String
    let image: UIImage?
    let select: Command
    
    var body: some View {
        Button(action: select) {
            VStack(alignment: .leading, spacing: 8) {
                Text(title)
                    .font(.headline)
                    .padding(.bottom, 4)
                
                HStack(alignment: .top, spacing: 8) {
                    if let image {
                        Image(uiImage: image)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 100, height: 150)
                            .cornerRadius(8)
                            .shadow(radius: 4)
                    } else {
                        Image(systemName: "photo")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 100, height: 150)
                            .foregroundColor(.gray)
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(8)
                    }
                    
                    Text(description)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .lineLimit(7)
                        .multilineTextAlignment(.leading)
                }
            }
        }
    }
}

extension MovieRowView: Equatable {
    static func == (lhs: MovieRowView, rhs: MovieRowView) -> Bool {
        lhs.title == rhs.title &&
        lhs.description == rhs.description &&
        lhs.image == rhs.image
    }
}

// MARK: - Preview

struct MovieRowView_Previews: PreviewProvider {
    static var previews: some View {
        MovieRowView(
            title: "The Shining",
            description: "Jack Torrance, an aspiring writer and recovering alcoholic, takes a job as the winter caretaker of the isolated Overlook Hotel, hoping to reconnect with his family and find inspiration for his writing. But as the harsh winter sets in, the hotel's eerie influence begins to affect Jack's sanity, leading him down a terrifying path of madness, violence, and the supernatural. As his son Danny, who possesses a unique psychic gift, begins to sense the horrors within the hotel, the Torrance family finds themselves in a desperate struggle for survival.",
            image: nil,
            select: nop)
    }
}
