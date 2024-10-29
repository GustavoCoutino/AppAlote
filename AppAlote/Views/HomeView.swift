//
//  Diego_Reto
//
//  Created by Alumno on 23/10/24.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        ZStack {
            // Contenido principal con desplazamiento
            ScrollView {
                VStack {
                    // Encabezado
                    HStack {
                        
                        Image(systemName: "bell")
                            .foregroundColor(.black)
                            .font(.system(size: 50))
                            .padding()
                        Spacer()
                        Image("Logo")
                        Spacer()
                        Image("menu")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .padding()
                        
                    }
                    .background(Color(red: 210/255, green: 210/255, blue: 73/255).frame(height: 100))
                    
                    
                    // Bienvenida personalizada
                    HStack {
                        Image("profile_picture")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .clipShape(Circle())
                            .padding(.leading,10)
                        Text("Gustavo Coutiño")
                            .font(.headline)
                            .padding(.leading,10)
                        Spacer()
                    }
                    .frame(height: 60)
                    .background(
                        RoundedRectangle(cornerRadius: 15)
                            .fill(Color.blue.opacity(0.6))
                            .shadow(radius: 5)
                    )
                    .padding(.horizontal,20)
                    
                    // Icono de museo
                    Image("Logo-Bienvenida")
                        .resizable()
                        .frame(width: 300, height: 300)
                        .padding()
                    
                    // Zonas para ti
                    Image("ZONAS PARA TI")
                        .resizable()
                        .frame(width: 250, height: 200)
                        .padding(.top, 16)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ZonaCardView(imageName: "Expreso", label: "Expreso", labelColor: .orange)
                            ZonaCardView(imageName: "Pertenezco", label: "Pertenezco", labelColor: .green)
                            ZonaCardView(imageName: "Comprendo", label: "Comprendo", labelColor: .purple)
                        }
                        .padding(.horizontal)
                    }
                    Image("Exhibiciones")
                        .resizable()
                        .frame(width: 250, height: 200)
                        .padding(.top,16)
                    VStack(spacing: 0){
                        Image("Dino")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 400, height: 230)
                            .clipped()
                        Text("Nombre de exhibicion")
                            .font(.subheadline)
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity, maxHeight: 100)
                            .background(Color(red:230/255, green: 245/255, blue: 221/255))
                    }
                    .frame(width: 400,height: 260)
                    .cornerRadius(12)
                    .shadow(radius: 4)
                }
                .padding(.bottom, 150) // Deja espacio para la barra de navegación
            }
            
            
            Navbar()
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}

struct ZonaCardView: View {
    let imageName: String
    let label: String
    let labelColor: Color
    
    var body: some View {
        VStack {
            Image(imageName)
                .resizable()
                .frame(width: 150, height: 150)
            
            Text(label)
                .font(.system(size: 20))
                .foregroundColor(labelColor)
                .padding(.top, 4)
        }
        .frame(width: 150, height: 200)
        .cornerRadius(12)
        .shadow(radius: 4)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
