//
//  ZoneView.swift
//  AppAlote
//
//  Created by Miguel Mendoza on 29/10/24.
//

import SwiftUI

struct ZoneView: View {
    
    let name: String
    let exhibitions = 12
    let message = "Pertenezco a una gran red de vida en la que todo se relaciona para funcionar."
    let description = "Si eres un explorador será tu lugar favorito, podrás aprender sobre diversas especies animales, características de la tierra y hasta interactuar con lombrices reales. Poco a poco te darás cuenta de que pertenecemos a una gran red de vida en la que todo se relaciona para funcionar."
    let images = ["image 13", "image 73"]

    var body: some View {
        VStack(spacing: 16) {
            Text(name)
                .font(.title)
                .bold()
                .padding(.top)
            
            ScrollView {
                VStack(spacing: 16) {
                    ZStack(alignment: .top) {
                        Image("\(name) LOGO")
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
                        Text("\(exhibitions) exhibiciones")
                            .font(.subheadline)
                            .padding(.top, 8)
                        
                        Text(message)
                            .font(.headline)
                            .padding()
                            .background(Color(red: 216/255, green: 245/255, blue: 97/255))
                            .cornerRadius(8)
                            .padding(.horizontal)
                        
                        Text(description)
                            .padding(.horizontal)
                        
                        HStack(spacing: 16) {
                            ForEach(images, id: \.self) { imageName in
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
    ZoneView(name: "PERTENEZCO")
}
