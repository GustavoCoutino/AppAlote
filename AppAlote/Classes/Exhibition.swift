//
//  Exhibition.swift
//  AppAlote
//
//  Created by Miguel Mendoza on 11/17/24.
//

struct Exhibition: Codable{
    let id: Int
    let nombre : String
    let zona : String
    let img : String
    let piso : Int
    let disponibilidad : Bool
    let mensaje_es : String
    let mensaje_en : String
    let objetivos : [Objective]
}
