//
//  LoginProgressView.swift
//  MoviesDB
//
//  Created by Denis Silko on 26.08.2024.
//

import SwiftUI

struct LoginProgressView: View, Equatable {
    let progress: Progress
    
    var body: some View {
        VStack(spacing: Constants.Layout.verticalSpacing) {
            ProgressView()
            Text(progress.rawValue)
        }
        .padding()
    }
    
    // MARK: - Inner types
    
    enum Progress: String {
        case idle = ""
        case authenticating = "Authenticating..."
        case validating = "Checking credentials..."
        case creatingUserSession = "Creating user session..."
        case creatingGuestSession = "Creating guest session..."
    }
}

// MARK: - Preview

struct LoginProgressView_Previews: PreviewProvider {
    static var previews: some View {
        LoginProgressView(progress: .authenticating)
    }
}
