//
//  TarjetasView.swift
//  AppAlote
//
//  Created by Miguel Mendoza on 31/10/24.
//

import SwiftUI

struct TarjetasView: View {
    @Binding var selectedCardImage: String
    
    let cardImages = ["fondo1", "fondo2", "fondo3", "fondo4", "fondo5","fondo6"]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                ForEach(cardImages, id: \.self) { cardImage in
                    ZStack {
                        Image(cardImage)
                            .resizable()
                            .frame(height: 100)
                            .cornerRadius(10)
                            .onTapGesture {
                                selectedCardImage = cardImage
                            }
                        
                        if selectedCardImage == cardImage {
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
    }
}

#Preview {
    TarjetasView(selectedCardImage: .constant("fondo1"))
}
