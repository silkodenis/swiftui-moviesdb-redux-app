//
//  RatingView.swift
//  MoviesDB
//
//  Created by Denis Silko on 05.09.2024.
//

import SwiftUI

struct RatingView: View {
    let rating: Double
    
    var body: some View {
        let clampedRating = min(max(rating, 0), 10)
        
        VStack(alignment: .center, spacing: 4) {
            Text("\(String(format: "%.1f", clampedRating)) / 10")
                .font(.body)
            
            HStack(spacing: 2) {
                let fullStars = Int(clampedRating)
                let remainingStars = 10 - fullStars

                ForEach(0..<fullStars, id: \.self) { _ in
                    Text("⭐️")
                        .font(.caption)
                }
                
                ForEach(0..<remainingStars, id: \.self) { _ in
                    Text("⭐️")
                        .opacity(0.4)
                        .font(.caption)
                }
            }
        }
    }
}

#Preview {
    RatingView(rating: 8.234)
//    RatingView(rating: 32.44)
}
