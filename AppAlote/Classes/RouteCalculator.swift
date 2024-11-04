//
//  RouteCalculator.swift
//  AppAlote
//
//  Created by Gustavo Coutiño on 23/10/24.
//

import SwiftUI
import Combine

class RouteCalculator: ObservableObject {
    private var userManager: UserManager
    @Published private var colorCounts: [Color: Int] = [
        Color(red: 173/255, green: 216/255, blue: 230/255): 0, // Pequeños
        Color.green: 0, // Pertenezco
        Color.blue: 0, // Comunico
        Color(red: 0/255, green: 0/255, blue: 139/255): 0, // Comprendo
        Color.orange: 0, // Expreso
        Color.red: 0 // Soy
    ]
    
    private let colorToZona: [Color: Zona] = [
        Color(red: 173/255, green: 216/255, blue: 230/255): Zona(id: "1", logo: URL(string: "https://example.com/logo1.png")!, nombre: "Pequeños"),
        Color.green: Zona(id: "2", logo: URL(string: "https://example.com/logo2.png")!, nombre: "Pertenezco"),
        Color.blue: Zona(id: "3", logo: URL(string: "https://example.com/logo3.png")!, nombre: "Comunico"),
        Color(red: 0/255, green: 0/255, blue: 139/255): Zona(id: "4", logo: URL(string: "https://example.com/logo4.png")!, nombre: "Comprendo"),
        Color.orange: Zona(id: "5", logo: URL(string: "https://example.com/logo5.png")!, nombre: "Expreso"),
        Color.red: Zona(id: "6", logo: URL(string: "https://example.com/logo6.png")!, nombre: "Soy")
    ]
    
    func recordAnswer(color: Color) {
        if let count = colorCounts[color] {
            colorCounts[color] = count + 1
        }
    }
    
    init(userManager: UserManager) {
        self.userManager = userManager
    }
    
    func submitQuizResults() async {
        for (color, count) in colorCounts{
            if let zona = colorToZona[color] {
                await userManager.postZoneScore(score: count, zona: zona)
            }
        }
    }
}
