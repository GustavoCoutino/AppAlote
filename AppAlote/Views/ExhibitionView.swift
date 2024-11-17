//
//  ExhibitionView.swift
//  AppAlote
//
//  Created by Miguel Mendoza on 29/10/24.
//

import SwiftUI

struct ExhibitionView: View {
    let name : String
    let zone = "Pertenezco"
    let floor = 1
    let image = "image"
    let availability = true
    let message = "El suelo esta formado por diferentes capas"
    let description = "Conocer cinco muestras del suelo del estado de Nuevo León. Distinguir las diferencias entre algunas capas del suelo. Comprenda la relación que existre en la composición de capa tipo de suelo y las plantas que viven en él."

    
    var body: some View {
        VStack(spacing: 16) {
            Text(name)
                .font(.title)
                .bold()
                .padding(.top)
                    
            ScrollView {
                VStack(spacing: 16) {
                    ZStack(alignment: .top) {
                        Image("\(zone) LOGO")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 300, height: 300)
                        Text("Exhibición")
                            .font(.headline)
                            .padding(8)
                            .background(Color.black.opacity(0.6))
                            .foregroundColor(.white)
                            .cornerRadius(8)
                            .padding(.top, 8)
                    }
                            
                    HStack {
                        Text("Zona: \(zone)")
                        Spacer()
                        Text("Piso: \(floor)")
                        Spacer()
                        Text(availability ? "Disponible" : "No Disponible")
                            .foregroundColor(availability ? .green : .red)
                    }
                    .font(.subheadline)
                    .padding(.horizontal)
                            
                    Text(message)
                        .font(.headline)
                        .padding()
                        .background(Color(red: 216/255, green: 245/255, blue: 97/255))
                        .cornerRadius(8)
                        .padding(.horizontal)
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Objetivos de la exhibición:")
                            .font(.headline)
                            .padding(.bottom, 4)
                        Text(description)
                            .font(.subheadline)
                            .padding(.horizontal)
                    }
                    .padding()
                    
                }
            }
        }
        .padding()
    }
}

#Preview {
    ExhibitionView(name: "ESTRATOS")
}
