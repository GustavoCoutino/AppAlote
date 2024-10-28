//
//  Zona.swift
//  AppAlote
//
//  Created by Gustavo Coutiño on 27/10/24.
//


import Foundation

class Zona {
    var nombre: String
    var imagen: String
    var numeroExhibiciones: Int
    var descripcionMain: String
    var descripcionLarga: String
    var imagenes: [String]
    
    init(nombre: String, imagen: String, numeroExhibiciones: Int, descripcionMain: String, descripcionLarga: String, imagenes: [String]) {
        self.nombre = nombre
        self.imagen = imagen
        self.numeroExhibiciones = numeroExhibiciones
        self.descripcionMain = descripcionMain
        self.descripcionLarga = descripcionLarga
        self.imagenes = imagenes
    }
}
