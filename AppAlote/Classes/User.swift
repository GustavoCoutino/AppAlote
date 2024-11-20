//
//  User.swift
//  AppAlote
//
//  Created by Miguel Mendoza on 11/20/24.
//

import Foundation

struct User : Codable {
    let id_usuario: String
    let foto_perfil: String
    let nombre: String
    let apellido: String
    let correo: String
}
