//
//  Traced.swift
//  MoviesDB
//
//  Created by Denis Silko on 08.08.2024.
//

import SwiftUI

struct Traced<C: View>: View {
    let name: String
    let content: C
    var body: some View {
        print("Render: \(name)")
        return content
    }
}

extension View {
    func trace(_ name: String) -> some View {
        Traced(name: name, content: self)
    }
}
