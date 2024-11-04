//
//  QuizScore.swift
//  AppAlote
//
//  Created by Gustavo Coutiño on 03/11/24.
//

import Foundation

struct QuizScore: Codable {
    let id: Int
    let puntaje_quiz: Int
    let fecha_registro: String 
    let usuario: String
    let zona: Int
}
