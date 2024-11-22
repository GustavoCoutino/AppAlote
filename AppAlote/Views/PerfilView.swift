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
    //@State private var password = ""
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var errorTitle = ""
    @State var showSignOutAlert = false
    
    @State var changed = false
    
    func loadUserData() {
        firstName = userManager.name
        lastName = userManager.lastName
        email = userManager.email
       let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if let date = dateFormatter.date(from: userManager.dateOfBirth) {
            birthDate = date
        }
    }
    
    var disabled : Bool {
        let dateFormatter = DateFormatter()
         dateFormatter.dateFormat = "yyyy-MM-dd"
        let formattedBirthDate = dateFormatter.string(from: birthDate)
        
        return firstName.isEmpty || lastName.isEmpty || email.isEmpty || (formattedBirthDate == userManager.dateOfBirth && firstName == userManager.name && lastName == userManager.lastName && email == userManager.email)
    }

    var body: some View {
        ScrollView {
            ZStack {
                
                /*
                    Circle()
                        .fill(Color.blue)
                        .frame(width: 120, height: 120)
                        .offset(x: -60, y: -250)
                 */
                
                    
                    Triangle()
                        .stroke(Color.red, lineWidth: 4)
                        .frame(width: 100, height: 100)
                        .offset(x: 130, y: -60)
                        .rotationEffect(.degrees(10), anchor: .center)
                    
                    Triangle()
                        .stroke(Color.green, lineWidth: 4)
                        .frame(width: 90, height: 90)
                        .offset(x: -30, y: 40)
                        .rotationEffect(.degrees(190), anchor: .center)
                    
                    Circle()
                        .stroke(Color.yellow, style: StrokeStyle(lineWidth: 4, dash: [8]))
                        .frame(width: 100, height: 100)
                        .offset(x: 190, y: -145)
                
                VStack(spacing: 20){
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Nombre")
                                .foregroundColor(.purple)
                            TextField("Nombre", text: $firstName)
                                .padding()
                                .background(Color(red: 255 / 255, green: 244 / 255, blue: 204 / 255))
                                .cornerRadius(10)
                               
                        }
                        
                        VStack(alignment: .leading) {
                            Text("Apellido")
                                .foregroundColor(.purple)
                            TextField("Apellido", text: $lastName)
                                .padding()
                                .background(Color(red: 255 / 255, green: 244 / 255, blue: 204 / 255))                             .cornerRadius(10)
                                
                        }
                    }
                    .padding(.top, 5)
                    
                    VStack(alignment: .leading) {
                        Text("Correo electrónico")
                            .foregroundColor(.purple)
                        TextField("Correo electrónico", text: $email)
                            .padding()
                            .background(Color(red: 255 / 255, green: 244 / 255, blue: 204 / 255))                            .cornerRadius(10)
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
                        .background(Color(red: 255 / 255, green: 244 / 255, blue: 204 / 255))                        .cornerRadius(10)
                        
                    }
                    
                    /*
                    VStack(alignment: .leading) {
                        Text("Contraseña")
                            .foregroundColor(.purple)
                        SecureField("Contraseña", text: $password)
                            .padding()
                            .background(Color(red: 255 / 255, green: 244 / 255, blue: 204 / 255))                            .cornerRadius(10)
                    }
                     */
                    
                    HStack(spacing: 20) {
                        Button(action: {
                            // userManager.signOut()
                            showSignOutAlert = true
                        }) {
                            Text("Cerrar sesión")
                                .frame(maxWidth: .infinity, minHeight: 44)
                        }
                        .padding()
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        
                        Button(action: {
                            if firstName.isEmpty || lastName.isEmpty || email.isEmpty {
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
                                        correo: email
                                    )
                                    isLoading = false
                                    alertMessage = "Su perfil ha sido actualizado existosamente"
                                    showAlert = true
                                    errorTitle = "Perfil actualizado"
                                    changed = false
                                }
                            }
                        }) {
                            if isLoading {
                                ProgressView()
                                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                                    .frame(maxWidth: .infinity, minHeight: 44)
                            } else {
                                Text("Guardar")
                                    .frame(maxWidth: .infinity, minHeight: 44)
                            }
                        }
                        .disabled(
                            disabled
                        )
                        .padding()
                        .background(
                            disabled ? Color(red: 126 / 255, green: 113 / 255, blue: 138 / 255) : Color.purple
                        )
                        .foregroundColor(.white)
                        .cornerRadius(10)

                        
                    }
                    .alert(isPresented: $showSignOutAlert) {
                        Alert(
                            title: Text("Cerrar sesión"),
                            message: Text("¿Estás seguro? Al cerrar sesión tendrás que iniciar sesión e ingresar el código de acceso nuevamente."),
                            primaryButton: .default(Text("Cerrar sesión")) {
                                userManager.signOut()
                            },
                            secondaryButton: .cancel()
                        )
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
                    .padding(.top, 5)
                }
            }
            .padding(.horizontal)
        }.onAppear{
            Task {
                await userManager.loadData()
            }
            loadUserData()
        }
        .alert(isPresented: $showSignOutAlert) {
            Alert(
                title: Text("Cerrar sesión"),
                message: Text("¿Estás seguro? Al cerrar sesión tendrás que iniciar sesión e ingresar el código de acceso nuevamente."),
                primaryButton: .default(Text("Cerrar sesión")) {
                    userManager.signOut()
                },
                secondaryButton: .cancel()
            )
        }
        Spacer().frame(height: 120)
    }
}

#Preview {
    PerfilView()
        .environmentObject(UserManager())
}
