//
//  PerfilView.swift
//  AppAlote
//
//  Created by Miguel Mendoza on 11/17/24.
//

import SwiftUI
struct PerfilView: View {
    @EnvironmentObject var userManager: UserManager
    @State private var isLoading = false
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var email = ""
    @State private var birthDate = Date()
    @State private var password = ""
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var errorTitle = ""
    
    func loadUserData() {
            let defaults = UserDefaults.standard
            firstName = defaults.string(forKey: "nombre") ?? ""
            lastName = defaults.string(forKey: "apellido") ?? ""
            email = defaults.string(forKey: "correo") ?? ""
            
            if let dateString = defaults.string(forKey: "fechaNacimiento") {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd"
                if let date = dateFormatter.date(from: dateString) {
                    birthDate = date
                }
            }
            password = ""
        }

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                ZStack {
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
                
                VStack(alignment: .leading) {
                    Text("Correo electrónico")
                        .foregroundColor(.purple)
                    TextField("Correo electrónico", text: $email)
                        .padding()
                        .background(Color.yellow.opacity(0.2))
                        .cornerRadius(10)
                        .textInputAutocapitalization(.never)
                }
                
                VStack(alignment: .leading) {
                    Text("Fecha de nacimiento")
                        .foregroundColor(.purple)
                    DatePicker(
                        "Selecciona fecha de nacimiento",
                        selection: $birthDate,
                        displayedComponents: .date
                    )
                    .datePickerStyle(CompactDatePickerStyle())
                    .padding()
                    .background(Color.yellow.opacity(0.2))
                    .cornerRadius(10)
                }
                
                VStack(alignment: .leading) {
                    Text("Contraseña")
                        .foregroundColor(.purple)
                    SecureField("Contraseña", text: $password)
                        .padding()
                        .background(Color.yellow.opacity(0.2))
                        .cornerRadius(10)
                }
                
                HStack(spacing: 20) {
                    Button(action: {
                        if firstName.isEmpty || lastName.isEmpty || email.isEmpty || password.isEmpty {
                            alertMessage = "Por favor, complete todos los campos."
                            showAlert = true
                            errorTitle = "error"
                        } else {
                            Task {
                                isLoading = true
                                await userManager.modifyProfile(
                                    nombre: firstName,
                                    apellido: lastName,
                                    fecha: birthDate,
                                    password: password,
                                    correo: email
                                )
                                isLoading = false
                                alertMessage = "Su perfil ha sido actualizado existosamente"
                                showAlert = true
                                errorTitle = "Perfil actualizado"
                            }
                        }
                    }) {
                        if isLoading {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: .white))
                                .frame(maxWidth: .infinity, minHeight: 44)
                        } else {
                            Text("Editar cuenta")
                                .frame(maxWidth: .infinity, minHeight: 44)
                        }
                    }
                    .padding()
                    .background(Color.purple)
                    .foregroundColor(.white)
                    .cornerRadius(10)

                    Button(action: {
                        userManager.signOut()
                    }) {
                        Text("Cerrar sesión")
                            .frame(maxWidth: .infinity, minHeight: 44)
                    }
                    .padding()
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
                .alert(isPresented: $showAlert) {
                    Alert(
                        title: Text(errorTitle),
                        message: Text(alertMessage),
                        dismissButton: .default(Text("OK"), action: {
                            userManager.clearError()
                        })
                    )
                }
                .padding(.top, 20)
            }
            .padding(.horizontal)
        }.onAppear{
            loadUserData()
        }
        Spacer().frame(height: 120)
    }
}

#Preview {
    PerfilView()
        .environmentObject(UserManager())
}
