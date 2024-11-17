//
//  ExhibitionView.swift
//  AppAlote
//
//  Created by Miguel Mendoza on 29/10/24.
//

import SwiftUI

struct ExhibitionView: View {
    let name : String
    @State var fetchedExhibition : Exhibition?
    @EnvironmentObject var userManager: UserManager
    var body: some View {
        VStack(spacing: 16) {
        if let exhibition = fetchedExhibition {
                Text(name)
                    .font(.title)
                    .bold()
                    .padding(.top)
                ScrollView {
                    VStack(spacing: 16) {
                        ZStack(alignment: .top) {
                            if let url = URL(string: exhibition.img) {
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
                            }
                            Text("Exhibición")
                                .font(.headline)
                                .padding(8)
                                .background(Color.black.opacity(0.6))
                                .foregroundColor(.white)
                                .cornerRadius(8)
                                .padding(.top, 8)
                        }
                                
                        HStack {
                            Text(exhibition.zona)
                            Spacer()
                            Text("Piso: \(exhibition.piso)")
                            Spacer()
                            Text(exhibition.disponibilidad ? "Disponible" : "No Disponible")
                                .foregroundColor(exhibition.disponibilidad ? .green : .red)
                        }
                        .font(.subheadline)
                        .padding(.horizontal)
                                
                        Text(exhibition.mensaje_es)
                            .font(.headline)
                            .padding()
                            .background(Color(red: 216/255, green: 245/255, blue: 97/255))
                            .cornerRadius(8)
                            .padding(.horizontal)
                        /*
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Objetivos de la exhibición:")
                                .font(.headline)
                                .padding(.bottom, 4)
                            Text(description)
                                .font(.subheadline)
                                .padding(.horizontal)
                        }
                        .padding()
                         */
                        
                    }
                }
            
            }
        }
        .padding()
        .onAppear{
            Task {
                fetchedExhibition = await userManager.fetchExhibitionData(exhibition: name)
            }
        }
    }
        
}

#Preview {
    ExhibitionView(name: "ESTRATOS").environmentObject(UserManager())
}
