//
//  LogoutBarItem.swift
//  MoviesDB
//
//  Created by Denis Silko on 29.05.2024.
//

import SwiftUI

struct LogoutBarItem: ToolbarContent {
    let action: () -> Void
    
    var body: some ToolbarContent {
        ToolbarItem(placement: .navigationBarTrailing) {
            Button(action: action) {
                Text("Logout")
            }
        }
    }
}

struct BarItem: ToolbarContent {
    let title: String
    let placement: ToolbarItemPlacement = .navigationBarTrailing
    let action: () -> Void
    
    var body: some ToolbarContent {
        ToolbarItem(placement: .navigationBarTrailing) {
            Button(action: action) {
                Text(title)
            }
        }
    }
}
