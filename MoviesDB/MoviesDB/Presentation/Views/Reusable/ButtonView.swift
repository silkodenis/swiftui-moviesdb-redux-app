//
//  ButtonViews.swift
//  MoviesDB
//
//  Created by Denis Silko on 09.08.2024.
//

import SwiftUI

struct ButtonView: View {
    let title: String
    let color: Color
    let isDisabled: Bool
    let action: () -> Void
    
    internal init(_ title: String, 
                  color: Color = .blue,
                  isDisabled: Bool = false,
                  action: @escaping () -> Void) {
        self.title = title
        self.color = color
        self.isDisabled = isDisabled
        self.action = action
    }
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .foregroundColor(.white)
                .font(.title2)
                .bold()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: 60)
        .background(isDisabled ? .gray.opacity(0.6) : color)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .disabled(isDisabled)
        .contentShape(Rectangle())
    }
}

#Preview {
    ButtonView("Log in") {}.padding()
}
