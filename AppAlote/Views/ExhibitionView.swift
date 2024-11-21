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
                            if exhibition.img.isEmpty{
                                Image(systemName: "photo")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 300, height: 300)
                                    .foregroundColor(.gray)
                                /*
                                Image("\(exhibition.zona) LOGO")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 300, height: 300)
                                    .foregroundColor(.gray)
                                */
                            } else {
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

                            }
                            VStack{
                                Text("Exhibición")
                                    .font(.headline)
                                    .padding(8)
                                    .background(Color.black)
                                    .foregroundColor(.white)
                                    .cornerRadius(8)
                            }
                            .padding(.top, 15)
                            
                        }
                                
                        HStack {
                            Text("Zona: \(exhibition.zona)")
                            Spacer()
                            Text("Piso: \(exhibition.piso)")
                            Spacer()
                            Text(exhibition.disponibilidad ? "Disponible" : "No Disponible")
                                .foregroundColor(exhibition.disponibilidad ? .green : .red)
                        }
                        .font(.subheadline)
                        .padding(.horizontal, 5)
                        
                        VStack{
                            Text(exhibition.mensaje_es)
                                .font(.headline)
                                .multilineTextAlignment(.center)
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color(red: 216/255, green: 245/255, blue: 97/255))
                        .cornerRadius(8)
                        
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
                .padding()
            
            }
        }
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
