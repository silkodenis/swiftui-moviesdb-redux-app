//
//  TextFieldViewModifier.swift
//  MyMVVM
//
//  Created by Denis Silko on 16.04.2024.
//

import SwiftUI

struct TextFieldViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .background(.gray.opacity(0.1))
            .clipShape(RoundedRectangle(cornerRadius: 15))
            .textFieldStyle(.plain)
    }
}

extension View {
    func textfieldStyle() -> some View {
        modifier(TextFieldViewModifier())
    }
}
