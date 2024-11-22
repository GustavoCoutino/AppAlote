//
//  Post.swift
//  AppAlote
//
//  Created by Gustavo Coutiño on 21/11/24.
//

struct Post : Identifiable, Codable {
    let id : Int
    let id_usuario : String
    let nombre : String
    let foto_perfil : String?
    let tarjeta : String?
    let insignia : String?
    let descripcion : String?
    let img : String?
    let id_exhibicion : String?
    let nombre_exhibicion : String?
}
