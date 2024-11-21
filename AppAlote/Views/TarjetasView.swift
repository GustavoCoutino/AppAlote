//
//  TarjetasView.swift
//  AppAlote
//
//  Created by Miguel Mendoza on 31/10/24.
//

import SwiftUI

struct TarjetasView: View {
    @Binding var selectedCardImage: String
    @State private var cards: [Tarjetas] = []
    @EnvironmentObject var userManager: UserManager
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                ForEach(cards) { card in
                    ZStack {
                        AsyncImage(url: URL(string: card.imagen)) { image in image
                                .resizable()
                                .frame(height: 100)
                                .grayscale(card.obtenido ? 0 : 1)
                                .opacity(card.obtenido ? 1 : 0.5)
                                .onTapGesture {
                                    if card.obtenido {
                                        selectedCardImage = card.imagen
                                    }
                                }
                        } placeholder: {
                            ProgressView()
                        }
                        
                        if selectedCardImage == card.imagen {
                            Image(systemName: "checkmark.circle.fill")
                                .resizable()
                                .foregroundColor(.green)
                                .frame(width: 30, height: 30)
                                .offset(x: 120, y: -30)
                        }
                    }
                }
                Button(action: {
                    if !selectedCardImage.isEmpty {
                        Task {
                            await userManager.updateTarjeta(imagen: selectedCardImage)
                        }
                    }
                }) {
                    Text("Actualizar tarjeta")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(selectedCardImage.isEmpty ? Color.gray : Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .padding()
                .disabled(selectedCardImage.isEmpty)
            }
            .padding()
        }
        
        .onAppear{
            Task {
                cards = await userManager.fetchTarjetas()
            }
        }
    }
}
