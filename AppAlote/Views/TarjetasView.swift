//
//  TarjetasView.swift
//  AppAlote
//
//  Created by Miguel Mendoza on 31/10/24.
//

import SwiftUI

struct TarjetasView: View {
    @State var selectedCardImage = ""
    @State private var cards: [Tarjetas] = []
    @EnvironmentObject var userManager: UserManager
    @State private var showingAlert = false
    
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
                                    if !card.obtenido {
                                        selectedCardImage = card.imagen
                                        showingAlert = true
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
            }
            .padding()
        }
        .alert(isPresented: $showingAlert) {
            Alert(
                title: Text("Confirmar cambio"),
                message: Text("Quieres cambiar tu tarjeta?"),
                primaryButton: .default(Text("Cambiar")) {
                    Task {
                        await userManager.updateTarjeta(imagen: selectedCardImage)
                    }
                },
                secondaryButton: .cancel()
            )
        }
        .onAppear{
            Task {
                cards = await userManager.fetchTarjetas()
            }
        }
    }
}
