//
//  ZonaViewModel.swift
//  AppAlote
//
//  Created by Gustavo Coutiño on 27/10/24.
//

import Foundation

class ZonaViewModel: ObservableObject {
    @Published var zona = Zona(
        nombre: "Pertenezco",
        imagen: "pertenezco",
        numeroExhibiciones: 12,
        descripcionMain: "Pertenezco a una gran red de vida en la que todo se relaciona para funcionar.",
        descripcionLarga: "Si eres un explorador será tu lugar favorito, podrás aprender sobre diversas especies animales, características de la tierra y hasta interactuar con lombrices reales. Poco a poco te darás cuenta de que pertenecemos a una gran red de vida en la que todo se relaciona para funcionar.",
        imagenes: ["image 13", "image 73"] 
    )
}
