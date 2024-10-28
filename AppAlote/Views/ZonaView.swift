//
//  ZonaView.swift
//  AppAlote
//
//  Created by Gustavo Coutiño on 26/10/24.
//

import SwiftUI

struct ZonaView: View {
    @ObservedObject var viewModel = ZonaViewModel()
    
    var body: some View {
        VStack(spacing: 16) {
            Text(viewModel.zona.nombre)
                .font(.title)
                .bold()
                .padding(.top)
            
            ScrollView {
                VStack(spacing: 16) {
                    ZStack(alignment: .top) {
                        Image(viewModel.zona.imagen)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 300, height: 300)
                        Text("Zona")
                            .font(.headline)
                            .padding(8)
                            .background(Color.black.opacity(0.6))
                            .foregroundColor(.white)
                            .cornerRadius(8)
                            .padding(.top, 8)
                    }
                    
                    VStack(spacing: 16) {
                        Text("\(viewModel.zona.numeroExhibiciones) exhibiciones")
                            .font(.subheadline)
                            .padding(.top, 8)
                        
                        Text(viewModel.zona.descripcionMain)
                            .font(.headline)
                            .padding()
                            .background(Color(red: 216/255, green: 245/255, blue: 97/255))
                            .cornerRadius(8)
                            .padding(.horizontal)
                        
                        Text(viewModel.zona.descripcionLarga)
                            .padding(.horizontal)
                        
                        HStack(spacing: 16) {
                            ForEach(viewModel.zona.imagenes, id: \.self) { imageName in
                                Image(imageName)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 100)
                                    .cornerRadius(8)
                            }
                        }
                        .padding(.horizontal)
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 25, style: .continuous)
                            .fill(Color.white)
                            .shadow(radius: 5)
                    )
                    .padding(.horizontal)
                }
            }
        }
        .padding()
    }
}

#Preview {
    ZonaView()
}
