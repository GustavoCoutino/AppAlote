//
//  ProfileView.swift
//  AppAlote
//
//  Created by Miguel Mendoza on 31/10/24.
//

import SwiftUI

struct ProfileView: View {
    enum Tab {
            case logros, insignias, tarjetas
        }
        
        @State var name : String
        @State private var selectedTab: Tab = .logros
        @State private var selectedCardImage: String = "background1"
        
        var body: some View {
            VStack {
                VStack {
                    Image(selectedCardImage)
                        .resizable()
                        .scaledToFill()
                        .frame(height: 200)
                        .clipped()
                        .edgesIgnoringSafeArea(.all)
                        .overlay(
                            VStack {
                                Image(systemName: "person.circle.fill")
                                    .resizable()
                                    .frame(width: 100, height: 100)
                                    .foregroundColor(.blue)
                                Text(name)
                                    .font(.title)
                                    .fontWeight(.bold)
                            }
                        )
                    
                    HStack {
                        TabButton(title: "Logros", isSelected: selectedTab == .logros)
                            .onTapGesture {
                                selectedTab = .logros
                            }
                        TabButton(title: "Insignias", isSelected: selectedTab == .insignias)
                            .onTapGesture {
                                selectedTab = .insignias
                            }
                        TabButton(title: "Tarjetas", isSelected: selectedTab == .tarjetas)
                            .onTapGesture {
                                selectedTab = .tarjetas
                            }
                    }
                    .padding(.top)
                    Divider()
                }
                .padding()
                
                if selectedTab == .logros {
                    LogrosView()
                } else if selectedTab == .insignias {
                    InsigniasView()
                } else if selectedTab == .tarjetas {
                    TarjetasView(selectedCardImage: $selectedCardImage)
                }
            }
            .background(Color(.systemGray6).edgesIgnoringSafeArea(.all))
        }
}

#Preview {
    ProfileView(name: "Reyli")
}
