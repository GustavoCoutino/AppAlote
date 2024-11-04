//
//  UserManager.swift
//  AppAlote
//
//  Created by Gustavo Coutiño on 28/10/24.
//
import Foundation

@MainActor
class UserManager: ObservableObject {
    @Published var isAuthenticated = false
    @Published var hasAnsweredQuiz = false
    @Published var hasRecentAccessCode = false
    @Published var userID = ""
    @Published var errorMessage: String?
    @Published var isLoading = true
    
    private let defaults = UserDefaults.standard
    
    init() {
        resetAllDefaults() // DECOMMENT THIS LINE IF YOU DONT WANT TO PERSIST THE SESSION WHILE TESTING
        Task {
            await loadStoredSession()
        }
    }
    
    func resetAllDefaults() {
        if let appDomain = Bundle.main.bundleIdentifier {
            defaults.removePersistentDomain(forName: appDomain)
        }
    }
    
    private func loadStoredSession() async {
        userID = defaults.string(forKey: "userID") ?? ""
        print(userID)
        isAuthenticated = !userID.isEmpty
        
        
        hasRecentAccessCode = false
        let url = URL(string: "https://papalote-backend.onrender.com/api/configuracion-general/")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            if let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) {
                if let jsonArray = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]],
                   let firstObject = jsonArray.first,
                   let code = firstObject["codigo_acceso"] as? String {
                    
                    let savedCode = defaults.string(forKey: "accessCode") ?? ""
                    if savedCode == code {
                        print("Access Code: \(code), Saved Code: \(savedCode)")
                        defaults.set(code, forKey: "accessCode")
                        hasRecentAccessCode = true
                    }
                } else {
                    print("No access code found in JSON.")
                }
            } else {
                print("Error in server response:")
            }
        } catch {
            print("Error in the request: \(error.localizedDescription)")
        }
        
        hasAnsweredQuiz = defaults.bool(forKey: "hasAnsweredQuiz")
        isLoading = false
    }
    
    func signIn(name: String, date: Date, email: String, password: String) async {
        if name.isEmpty || email.isEmpty || password.isEmpty {
            errorMessage = "Campos faltantes"
            return
        }
        
        let url = URL(string: "https://papalote-backend.onrender.com/api/usuarios/")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateString = dateFormatter.string(from: date)
        
        print(dateString)
        
        let parameters: [String: String] = [
            "nombre": name,
            "apellido": name,
            "correo": email,
            "password_hash": password,
            "fecha_nacimiento": dateString
        ]
        
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else {
            errorMessage = "Error al procesar los datos de inicio de sesión."
            return
        }
        request.httpBody = httpBody
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            if let httpResponse = response as? HTTPURLResponse {
                print("HTTP Status Code: \(httpResponse)")
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]{
                    if let userID = json["id_usuario"] as? String {
                        self.userID = userID
                        defaults.set(userID, forKey: "userID")
                        isAuthenticated = true
                    } else {
                        if let detail = json["correo"] as? [String] {
                             errorMessage = detail[0]
                         }
                        if (errorMessage == "usuario with this correo already exists."){
                            errorMessage = "Usuario con este correo ya existe"
                        }
                    }
                } else {
                    errorMessage = "Error en la respuesta del servidor."
                }
            } else {
                errorMessage = "Error en la respuesta del servidor."
            }
        } catch {
            errorMessage = "Error en la solicitud: \(error.localizedDescription)"
        }

    }
    
    func logIn(email: String, password: String) async {
        if email.isEmpty || password.isEmpty {
            errorMessage = "Los campos del correo electrónico y contraseña son requeridos."
            return
        }
        
        let url = URL(string: "https://papalote-backend.onrender.com/api/login/")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let parameters: [String: String] = [
            "correo": email,
            "password": password
        ]
        
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else {
            errorMessage = "Error al procesar los datos de inicio de sesión."
            return
        }
        request.httpBody = httpBody
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            if let httpResponse = response as? HTTPURLResponse {
                print("HTTP Status Code: \(httpResponse.statusCode)")
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                   let detail = json["detail"] as? String {
                        if let userID = json["id_usuario"] as? String {
                            self.userID = userID
                            defaults.set(userID, forKey: "userID")
                            isAuthenticated = true
                            print("User ID:", self.userID, "Authenticated:", isAuthenticated)
                        } else {
                            errorMessage = detail
                        }
                    } else {
                        errorMessage = "Respuesta inesperada del servidor."
                    }
            } else {
                errorMessage = "Error en la respuesta del servidor."
            }
        } catch {
            errorMessage = "Error en la solicitud: \(error.localizedDescription)"
        }
    }
    
    func enterAccessCode(_ code: String) async {
        if code.isEmpty {
            errorMessage = "El campo del codigo de acceso es requerido."
            return
        }
        let url = URL(string: "https://papalote-backend.onrender.com/api/configuracion-general/")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            if let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) {
                if let jsonArray = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]],
                   let firstObject = jsonArray.first,
                   let currentCode = firstObject["codigo_acceso"] as? String {
                    
                    if currentCode == code {
                        print("Access Code: \(code), Saved Code: \(currentCode)")
                        defaults.set(code, forKey: "accessCode")
                        hasRecentAccessCode = true
                        return
                    } else {
                        hasRecentAccessCode = false
                        errorMessage = "Código de acceso incorrecto"
                    }
                } else {
                    print("No access code found in JSON.")
                }
            } else {
                print("Error in server response:")
            }
        } catch {
            print("Error in the request: \(error.localizedDescription)")
        }
        
        hasRecentAccessCode = false
    }
    
    func postZoneScore(score: Int, zona: Zona) async {
        let url = URL(string: "https://papalote-backend.onrender.com/api/preferencias/")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type") 
        
        let payload: [String: Any] = [
            "puntaje_quiz": score,
            "usuario": userID,
            "zona": zona.id
        ]
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: payload, options: [])
        } catch {
            errorMessage = "Error serializing JSON: \(error.localizedDescription)"
            print("Problema en la serializacion")
            return
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            if let httpResponse = response as? HTTPURLResponse {
                
                if (200...299).contains(httpResponse.statusCode) {
                    print("POST request successful for zona:", zona.nombre)
                } else {
                    errorMessage = "Hubo un error al terminar el quiz: \(httpResponse.statusCode)"
                }
            }
        } catch {
            errorMessage = "Hubo un error al terminar el quiz: \(error.localizedDescription)"
        }
    }
    
    func fetchUsername() async -> String {
        let url = URL(string: "https://papalote-backend.onrender.com/api/usuarios/\(userID)/")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            if let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]{
                    if let name = json["nombre"] as? String{
                        return name
                    }
                }
            }
        } catch {
            print("Error in the request: \(error.localizedDescription)")
        }
        return ""
    }
    
    func setQuizCompleted() {
        hasAnsweredQuiz = true
        defaults.set(true, forKey: "hasAnsweredQuiz")
    }
    
    func signOut() {
        userID = ""
        isAuthenticated = false
        hasRecentAccessCode = false
        defaults.removeObject(forKey: "userID")
        defaults.removeObject(forKey: "accessCode")
    }
    
    func clearError() {
        errorMessage = nil
    }
}
