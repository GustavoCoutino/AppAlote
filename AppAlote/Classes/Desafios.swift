//
//  Desafios.swift
//  AppAlote
//
//  Created by Gustavo Coutiño on 20/11/24.
//


struct Desafios : Codable, Identifiable {
    let id : Int
    let nombre_desafio : String
    let descripcion_es : String
    let progreso_actual : Int
    let valor_meta : Int
    let img_desafio : String
}
