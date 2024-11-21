//
//  Objective.swift
//  AppAlote
//
//  Created by Miguel Mendoza on 11/21/24.
//

import Foundation

struct Objective: Codable, Identifiable {
    let id = UUID()
    let descripcionEs: String
    let descripcionEn: String
    
    enum CodingKeys: String, CodingKey {
        case descripcionEs = "descripcion_es"
        case descripcionEn = "descripcion_en"
    }
}
