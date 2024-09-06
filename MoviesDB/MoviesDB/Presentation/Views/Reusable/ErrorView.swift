//
//  ErrorView.swift
//  MoviesDB
//
//  Created by Denis Silko on 26.08.2024.
//

import SwiftUI

struct ErrorView: View {
    let description: String
    let buttonTitle: String
    let buttonAction: Command
    
    var body: some View {
        VStack(spacing: Constants.Layout.verticalSpacing) {
            Text("🤷‍♂️").font(.system(size: 150))
            Text(description)
                .multilineTextAlignment(.center)
            Button(buttonTitle, action: buttonAction).font(.title3)
        }
        .padding()
    }
}

extension ErrorView: Equatable {
    static func == (lhs: ErrorView, rhs: ErrorView) -> Bool {
        lhs.description == rhs.description &&
        lhs.buttonTitle == rhs.buttonTitle
    }
}

#Preview {
    ErrorView(description: "Check your credentials",
              buttonTitle: "Try Again",
              buttonAction: nop)
}
