import SwiftUI

struct ContentView: View {
    
    enum Tab {
        case logros, insignias, tarjetas
    }
    
    @State private var selectedTab: Tab = .logros
    @State private var selectedCardImage: String = "background1" // Imagen inicial para el fondo
    
    var body: some View {
        VStack {
            // Parte superior con imagen y nombre de usuario
            VStack {
                Image(selectedCardImage) // Cambiará la imagen de fondo según la tarjeta seleccionada
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
                            Text("Reyli Cruz")
                                .font(.title)
                                .fontWeight(.bold)
                        }
                    )
                
                // Pestañas de Logros, Insignias y Tarjetas
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
            
            // Contenido dependiendo de la pestaña seleccionada
            if selectedTab == .logros {
                LogrosView()  // LogrosView.swift
            } else if selectedTab == .insignias {
                InsigniasView()  // InsigniasView.swift
            } else if selectedTab == .tarjetas {
                TarjetasView(selectedCardImage: $selectedCardImage)  // TarjetasView.swift
            }
        }
        .background(Color(.systemGray6).edgesIgnoringSafeArea(.all))
    }
}


#Preview {
    ContentView()
}
