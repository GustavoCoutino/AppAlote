//
//  Announcement.swift
//  AppAlote
//
//  Created by Miguel Mendoza on 11/20/24.
//

import Foundation

struct Announcement : Identifiable, Codable {
    let id: Int
    let fecha_creacion: String
    let titulo_es: String
    let titulo_en: String
    let descripcion_es : String
    let descripcion_en : String
}
