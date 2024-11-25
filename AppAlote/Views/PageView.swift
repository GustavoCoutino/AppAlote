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
        VStack {

            VStack(alignment: .leading, spacing: 20) {
                
                Text(page.titulo_es)
                    .font(.system(size: 18))
                    .bold()
                    .padding(.top, 55)
                
                Text(page.contenido_es)
                    .font(.system(size: 18))
                    .padding(.bottom, 30)
                
                if let url = URL(string: page.img) {
                    HStack {
                        AsyncImage(url: url) { phase in
                            switch phase {
                            case .empty:
                                ProgressView()
                                    .frame(width: 300, height: 300)
                            case .success(let image):
                                image
                                    .resizable()
                                    .scaledToFit()
                            default:
                                Image(systemName: "photo")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 300, height: 300)
                                    .foregroundColor(.gray)
                                
                            }
                        }
                    }
                }
            }
            .frame(maxWidth: 500)
            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color.yellow.opacity(0.1))
        .cornerRadius(10)

    }
}

#Preview {
    PageView(
        page: Page(img: "soil_layers", titulo_es: "Ejemplo", contenido_es: "Descripción de ejemplo", exhibicion: 1)
    )
}

