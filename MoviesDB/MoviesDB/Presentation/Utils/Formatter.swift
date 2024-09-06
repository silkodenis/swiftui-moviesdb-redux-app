//
//  Formatter.swift
//  MoviesDB
//
//  Created by Denis Silko on 05.09.2024.
//

import Foundation

struct Formatter {}

extension Formatter {
    static func duration(from minutes: Int?) -> String {
        guard let runtime = minutes else { return "N/A" }
        
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .abbreviated
        formatter.allowedUnits = [.minute, .hour]
        
        return formatter.string(from: TimeInterval(runtime * 60)) ?? "N/A"
    }
}
