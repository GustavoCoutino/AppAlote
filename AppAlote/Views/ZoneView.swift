//
//  ZoneView.swift
//  AppAlote
//
//  Created by Miguel Mendoza on 29/10/24.
//

import SwiftUI

struct ZoneView: View {
    let name: String
    @EnvironmentObject var userManager: UserManager
    @State var fetchedZone : Zone?
    @Environment(\.horizontalSizeClass) var sizeClass
    var body: some View {
        VStack(spacing: 16) {
            if let zone = fetchedZone {
                Text(formatText(zone.nombre))
                    .font(.title)
                    .bold()
                
                Text("\(zone.numero_exhibiciones) exhibiciones")
                    .font(.subheadline)
                    .padding(.bottom, 15)
                
                ScrollView {
                    VStack(spacing: 16) {
                        let columns: [GridItem] = {
                            if sizeClass == .regular {
                                return [
                                    GridItem(.adaptive(minimum: 250)),
                                    GridItem(.adaptive(minimum: 250))
                                ]
                            } else {
                                return [
                                    GridItem(.adaptive(minimum: UIScreen.main.bounds.width))
                                ]
                            }
                        }()
                        LazyVGrid(columns: columns) {
                            ZStack(alignment: .top) {
                                if let url = URL(string: zone.logo) {
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
                                VStack{
                                    Text("Zona")
                                        .font(.headline)
                                        .padding(8)
                                        .background(Color.black)
                                        .foregroundColor(.white)
                                        .cornerRadius(8)
                                }
                                .padding(.top, 15)
                                
                                
                            }
                          
                            VStack(spacing: 20){
                                
                                Text(zone.mensaje_es)
                                    .font(.headline)
                                    .multilineTextAlignment(.center)
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(Color(red: 216/255, green: 245/255, blue: 97/255))
                                    .cornerRadius(8)
                                
                                
                                Text(zone.descripcion_es)

                            }
                            .padding(.top, 20)
                            .padding(.horizontal, 30)

                            
                        }
                        .padding(.bottom, 30)
                        
                        VStack(spacing: 16) {
                            ForEach(zone.multimedia, id: \.self) { imageURL in
                                if let url = URL(string: imageURL) {
                                    AsyncImage(url: url) { phase in
                                        switch phase {
                                        case .empty:
                                            ProgressView()
                                                .frame(width: 150, height: 150)
                                        case .success(let image):
                                            image
                                                .resizable()
                                                .scaledToFit()
                                                .cornerRadius(8)
                                        default:
                                            Image(systemName: "photo")
                                                .resizable()
                                                .scaledToFit()
                                                .foregroundColor(.gray)
                                                .frame(maxWidth: 300)
                                        }
                                    }
                                }
                            }

                        }
                        .frame(maxWidth: 600)
                        .padding(.horizontal)
                    }
                    .frame(maxWidth: .infinity)
                    
                }
            }
        }
        .onAppear {
            Task {
                fetchedZone = await userManager.fetchZoneData(zone: name)
            }
        }
    }
}

#Preview {
    ZoneView(name: "PERTENEZCO").environmentObject(UserManager())
}
