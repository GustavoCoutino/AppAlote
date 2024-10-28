//
//  Exhibicion.swift
//  AppAlote
//
//  Created by Gustavo Coutiño on 26/10/24.
//


import Foundation

class Exhibicion {
    var nombre: String
    var imagen: String
    var zona: String
    var piso: Int
    var disponibilidad: Bool
    var descripcionMain: String
    var descripcionLarga: String
    
    init(nombre: String, imagen: String, zona: String, piso: Int, disponibilidad: Bool, descripcionMain: String, descripcionLarga: String) {
        self.nombre = nombre
        self.imagen = imagen
        self.zona = zona
        self.piso = piso
        self.disponibilidad = disponibilidad
        self.descripcionMain = descripcionMain
        self.descripcionLarga = descripcionLarga
    }
}

