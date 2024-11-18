//
//  PerfilView.swift
//  AppAlote
//
//  Created by Miguel Mendoza on 11/17/24.
//

import SwiftUI

struct PerfilView: View {
    @EnvironmentObject var userManager : UserManager
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var email = ""
    @State private var birthDate = ""
    @State private var password = ""
    @State private var goToLogin = false
    let languages = ["Español", "Inglés"]
    let themes = ["Claro", "Oscuro"]

    var body: some View {
        VStack() {
            ScrollView{
                ZStack{
                    Circle()
                        .fill(Color.blue)
                        .frame(width: 120, height: 150)
                        .offset(x: -120, y: 20)
                    
                    Triangle()
                        .stroke(Color.red, lineWidth: 4)
                        .frame(width: 100, height: 100)
                        .offset(x: -70, y: 600)
                        .rotationEffect(.degrees(10), anchor: .center)
                    
                    Triangle()
                        .stroke(Color.green, lineWidth: 4)
                        .frame(width: 90, height: 90)
                        .offset(x: 80, y: -50)
                        .rotationEffect(.degrees(165), anchor: .center)
                    
                    Circle()
                        .stroke(Color.yellow, style: StrokeStyle(lineWidth: 4, dash: [8]))
                        .frame(width: 100, height: 100)
                        .offset(x: 160, y: 400)
                }
                HStack {
                    VStack(alignment: .leading) {
                        Text("Nombre")
                            .foregroundColor(.purple)
                        TextField("Nombre", text: $firstName)
                            .padding()
                            .background(Color.yellow.opacity(0.2))
                            .cornerRadius(10)
                    }
                    
                    VStack(alignment: .leading) {
                        Text("Apellido")
                            .foregroundColor(.purple)
                        TextField("Apellido", text: $lastName)
                            .padding()
                            .background(Color.yellow.opacity(0.2))
                            .cornerRadius(10)
                    }
                }
                
                // Correo Electrónico
                VStack(alignment: .leading) {
                    Text("Correo electrónico")
                        .foregroundColor(.purple)
                    TextField("Correo electrónico", text: $email)
                        .padding()
                        .background(Color.yellow.opacity(0.2))
                        .cornerRadius(10)
                }
                
                // Fecha de Nacimiento
                VStack(alignment: .leading) {
                    Text("Fecha de nacimiento")
                        .foregroundColor(.purple)
                    TextField("Fecha de nacimiento", text: $birthDate)
                        .padding()
                        .background(Color.yellow.opacity(0.2))
                        .cornerRadius(10)
                }
                
                // Contraseña
                VStack(alignment: .leading) {
                    Text("Contraseña")
                        .foregroundColor(.purple)
                    SecureField("Contraseña", text: $password)
                        .padding()
                        .background(Color.yellow.opacity(0.2))
                        .cornerRadius(10)
                }
                HStack {
                                   VStack(alignment: .leading) {
                                       Text("Idioma")
                                           .foregroundColor(userManager.isDarkMode ? .white : .purple)
                                       
                                       Picker("Seleccione un idioma", selection: $userManager.selectedLanguage) {
                                           ForEach(languages, id: \.self) { language in
                                               Text(language).tag(language)
                                           }
                                       }
                                       .pickerStyle(MenuPickerStyle())
                                       .padding()
                                       .background(userManager.isDarkMode ? Color.gray.opacity(0.3) : Color.yellow.opacity(0.2))
                                       .cornerRadius(10)
                                   }
                                   
                                   VStack(alignment: .leading) {
                                       Text("Tema")
                                           .foregroundColor(userManager.isDarkMode ? .white : .purple)
                                       
                                       Picker("Seleccione un tema", selection: $userManager.isDarkMode) {
                                           Text("Claro").tag(false)
                                           Text("Oscuro").tag(true)
                                       }
                                       .pickerStyle(MenuPickerStyle())
                                       .padding()
                                       .background(userManager.isDarkMode ? Color.gray.opacity(0.3) : Color.yellow.opacity(0.2))
                                       .cornerRadius(10)
                                   }
                               }
                
                // Botones
                HStack(spacing: 20) {
                    Button(action: {
                        // Acción de editar cuenta
                    }) {
                        Text("Editar cuenta")
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.purple)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    
                    Button(action: {
                        goToLogin = true
                    }) {
                        Text("Cerrar sesión")
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.red)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
                .padding(.top, 20)
                
            }
        }
        .padding()
        .background(userManager.isDarkMode ? Color.black : Color.white) // Cambia el fondo según el tema
        
        
        .padding()
    }
        
}

#Preview {
    PerfilView()
        .environmentObject(UserManager())
}
