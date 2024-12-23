//
//  TarjetasView.swift
//  AppAlote
//
//  Created by Miguel Mendoza on 31/10/24.
//

import SwiftUI

struct TarjetasView: View {
    @State var selectedCardImage = ""
    @State var selectedCardImageID : Int = 0

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
                                .aspectRatio(contentMode: .fit)
                                .frame(maxWidth: .infinity)
                                .grayscale(card.obtenido ? 0 : 1)
                                .opacity(card.obtenido ? 1 : 0.5)
                                .onTapGesture {
                                    if card.obtenido {
                                        selectedCardImage = card.imagen
                                        selectedCardImageID = card.id
                                        showingAlert = true
                                    }
                                }
                                .disabled(userManager.banner == card.imagen)
                        } placeholder: {
                            ProgressView()
                        }
                                                
                        if userManager.banner == card.imagen {
                            HStack {
                                Spacer()
                                Image(systemName: "checkmark.circle.fill")
                                    .resizable()
                                    .foregroundColor(.green)
                                    .frame(width: 30, height: 30)
                                    .padding(.trailing, 10)
                            }
                        }
                    }
                }
            }
            .padding()
            Spacer().frame(height: 120)
        }
        .alert(isPresented: $showingAlert) {
            Alert(
                title: Text("Confirmar cambio"),
                message: Text("Quieres cambiar tu tarjeta?"),
                primaryButton: .default(Text("Cambiar")) {
                    userManager.uploadingBanner = true
                    Task {
                        await userManager.updateTarjeta(imagen: selectedCardImage, id: selectedCardImageID)
                    }
                },
                secondaryButton: .cancel {
                    selectedCardImage = userManager.banner
                    selectedCardImageID = 0
                }
            )
        }
        .onAppear{
            Task {
                cards = await userManager.fetchTarjetas()
            }

        }
    }
}
