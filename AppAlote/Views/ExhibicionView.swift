//
//  ExhibicionView.swift
//  AppAlote
//
//  Created by Gustavo Coutiño on 28/10/24.
//

import SwiftUI

struct ExhibicionView: View {
    @ObservedObject var viewModel = ExhibicionViewModel()
    
    var body: some View {
        VStack(spacing: 16) {
            Text(viewModel.exhibicion.nombre)
                .font(.title)
                .bold()
                .padding(.top)
            
            ScrollView {
                VStack(spacing: 16) {
                    ZStack(alignment: .top) {
                        Image(viewModel.exhibicion.imagen)
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
                        Text("Zona: \(viewModel.exhibicion.zona)")
                        Spacer()
                        Text("Piso: \(viewModel.exhibicion.piso)")
                        Spacer()
                        Text(viewModel.exhibicion.disponibilidad ? "Disponible" : "No Disponible")
                            .foregroundColor(viewModel.exhibicion.disponibilidad ? .green : .red)
                    }
                    .font(.subheadline)
                    .padding(.horizontal)
                    
                    Text(viewModel.exhibicion.descripcionMain)
                        .font(.headline)
                        .padding()
                        .background(Color(red: 216/255, green: 245/255, blue: 97/255))
                        .cornerRadius(8)
                        .padding(.horizontal)
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Objetivos de la exhibición:")
                            .font(.headline)
                            .padding(.bottom, 4)
                        Text(viewModel.exhibicion.descripcionLarga)
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
    ExhibicionView()
}
