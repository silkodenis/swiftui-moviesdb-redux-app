//
//  Keyboard.swift
//  MoviesDB
//
//  Created by Denis Silko on 05.09.2024.
//

import Foundation
import SwiftUI

struct Keyboard {
    static func hide() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
