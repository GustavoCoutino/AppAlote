//
//  PageView.swift
//  AppAlote
//
//  Created by Miguel Mendoza on 11/17/24.
//


import SwiftUI

struct PageView: View {
    var title: String
    var description: String
    var imageName: String
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text(title)
                .font(.headline)
            
            Text(description)
                .font(.body)
            
            Image(imageName)
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
    PageView(title: "Ejemplo", description: "Descripción de ejemplo", imageName: "soil_layers")
}

