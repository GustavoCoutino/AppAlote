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
            
            Image(page.img)
                .resizable()
                .scaledToFit()
                .frame(height: 200)
            
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

