//
//  ExhibicionViewModel.swift
//  AppAlote
//
//  Created by Gustavo Coutiño on 28/10/24.
//

import Foundation

import Foundation

class ExhibicionViewModel: ObservableObject {
    @Published var exhibicion = Exhibicion(
        nombre: "Estratos",
        imagen: "image",
        zona: "Pertenezco",
        piso: 2,
        disponibilidad: true,
        descripcionMain: "El suelo esta formado por diferentes capas",
        descripcionLarga: "Conocer cinco muestras del suelo del estado de Nuevo León. Distinguir las diferencias entre algunas capas del suelo. Comprenda la relación que existre en la composición de capa tipo de suelo y las plantas que viven en él."
    )
}
 
