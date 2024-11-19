//
//  PageView.swift
//  AppAlote
//
//  Created by Miguel Mendoza on 11/17/24.
//


import SwiftUI

struct PageView: View {
    var page : Page
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text(page.titulo_es)
                .font(.headline)
            
            Text(page.contenido_es)
                .font(.body)
            
            if let url = URL(string: page.img) {
                HStack {
                    Spacer()
                    AsyncImage(url: url) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                                .frame(width: 300, height: 300)
                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFit()
                                .frame(width: 300, height: 300)
                        default:
                            Image(systemName: "photo")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 300, height: 300)
                                .foregroundColor(.gray)
                            
                        }
                    }
                    Spacer()
                }
            }
            
            Spacer()
        }
        .padding()
        .background(Color(UIColor.systemGreen).opacity(0.1))
        .cornerRadius(10)
    }
}

#Preview {
    PageView(
        page: Page(img: "soil_layers", titulo_es: "Ejemplo", titulo_en: "Descripción de ejemplo", contenido_es: "Descripción de ejemplo", contenido_en: "Descripción de ejemplo", exhibicion: 1)
    )
}

