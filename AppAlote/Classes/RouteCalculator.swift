//
//  RouteCalculator.swift
//  AppAlote
//
//  Created by Gustavo Coutiño on 23/10/24.
//

import SwiftUI
import Combine

class RouteCalculator: ObservableObject {
    @Published private var colorCounts: [Color: Int] = [
        Color(red: 173/255, green: 216/255, blue: 230/255): 0, // Pequeños
        Color.green: 0, // Pertenezco
        Color.blue: 0, // Comunico
        Color(red: 0/255, green: 0/255, blue: 139/255): 0, // Comprendo
        Color.orange: 0, // Expreso
        Color.red: 0 // Soy
    ]
    
    private let colorToWord: [Color: String] = [
        Color(red: 173/255, green: 216/255, blue: 230/255): "Pequeños",
        Color.green: "Pertenezco",
        Color.blue: "Comunico",
        Color(red: 0/255, green: 0/255, blue: 139/255): "Comprendo",
        Color.orange: "Expreso",
        Color.red: "Soy"
    ]
    
    func recordAnswer(color: Color) {
        if let count = colorCounts[color] {
            colorCounts[color] = count + 1
        }
    }
    
    func calculateRoute() -> [String] {
        let sortedColors = colorCounts.sorted { $0.value > $1.value }
        let route = sortedColors.map { colorToWord[$0.key]! }
        return route
    }
}

