//
//  Insignias.swift
//  AppAlote
//
//  Created by Gustavo Coutiño on 20/11/24.
//

struct Insignias : Codable, Identifiable {
    let id : Int
    let nombre_recompensa : String
    let imagen : String
    let obtenido : Bool
}
