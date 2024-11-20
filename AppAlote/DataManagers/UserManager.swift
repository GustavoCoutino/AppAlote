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
    @Published var currentDeepLink: String?
    @Published var selectedLanguage: String = "Español"
    @Published var isDarkMode: Bool = false
    @Published var selectedView: String = "Home"
    @Published var selectedAuthView : String = "LogIn"

    private let defaults = UserDefaults.standard
    
    init() {
        // resetAllDefaults() // DECOMMENT THIS LINE IF YOU DONT WANT TO PERSIST THE SESSION WHILE TESTING
        Task {
            await loadStoredSession()
        }
    }
    
    func handleURL(_ url: URL) {
        guard url.scheme == "AppAlote" else { return }
        let name = url.host
        if let name = name {
            currentDeepLink = name
        }
    }
    
    func resetAllDefaults() {
        if let appDomain = Bundle.main.bundleIdentifier {
            defaults.removePersistentDomain(forName: appDomain)
        }
    }
    
    private func loadStoredSession() async {
        userID = defaults.string(forKey: "userID") ?? ""
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
    
    func signIn(name: String, lastName: String, date: Date, email: String, password: String) async {
        if name.isEmpty || lastName.isEmpty || email.isEmpty || password.isEmpty {
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
                
        let parameters: [String: String] = [
            "nombre": name,
            "apellido": lastName,
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
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]{
                    if let userId = json["id_usuario"] as? String,
                    let nombre = json["nombre"] as? String,
                    let apellido = json["apellido"] as? String,
                    let correo = json["correo"] as? String,
                    let fechaNacimiento = json["fecha_nacimiento"] as? String {
                                        
                    let defaults = UserDefaults.standard
                    defaults.set(userId, forKey: "userID")
                    defaults.set(nombre, forKey: "nombre")
                    defaults.set(apellido, forKey: "apellido")
                    defaults.set(correo, forKey: "correo")
                    defaults.set(fechaNacimiento, forKey: "fechaNacimiento")
                                        
                    if let fotoPerfil = json["foto_perfil"] as? String {
                        defaults.set(fotoPerfil, forKey: "fotoPerfil")
                    }
                    userID = defaults.string(forKey: "userID") ?? ""
                    isAuthenticated = true
                                        
                } else {
                    if let detail = json["correo"] as? [String] {
                        errorMessage = detail[0]
                    }
                    if errorMessage == "usuario with this correo already exists." {
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
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                   let detail = json["detail"] as? String {
                    if detail == "Autenticación exitosa.",
                       let userId = json["id_usuario"] as? String,
                       let nombre = json["nombre"] as? String,
                       let apellido = json["apellido"] as? String,
                       let correo = json["correo"] as? String,
                       let fechaNacimiento = json["fecha_nacimiento"] as? String,
                       let fechaRegistro = json["fecha_registro"] as? String {
                       let defaults = UserDefaults.standard
                       defaults.set(userId, forKey: "userID")
                       defaults.set(nombre, forKey: "nombre")
                       defaults.set(apellido, forKey: "apellido")
                       defaults.set(correo, forKey: "correo")
                       defaults.set(fechaNacimiento, forKey: "fechaNacimiento")
                       defaults.set(fechaRegistro, forKey: "fechaRegistro")
                        if let fotoPerfil = json["foto_perfil"] as? String {
                            defaults.set(fotoPerfil, forKey: "fotoPerfil")
                        }
                        userID = defaults.string(forKey: "userID") ?? ""
                        isAuthenticated = true
                        await checkQuizCompletion()
                                        
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
            let (_, response) = try await URLSession.shared.data(for: request)
            
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
    
    func fetchUserQuizScore() async -> [QuizScore] {
        let url = URL(string: "https://papalote-backend.onrender.com/api/preferencias/")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            if let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) {
                let allScores = try JSONDecoder().decode([QuizScore].self, from: data)
                let userScores = allScores.filter { $0.usuario == userID }
                return userScores
            } else {
                print("Failed to fetch scores. Status code:", (response as? HTTPURLResponse)?.statusCode ?? -1)
            }
        } catch {
            print("Error decoding response:", error.localizedDescription)
            errorMessage = "Hubo un error al obtener los resultados del quiz: \(error.localizedDescription)"
        }
        return []
    } 
    
    func checkQuizCompletion() async {
        if !hasAnsweredQuiz {
            let userScores = await fetchUserQuizScore()
            if !userScores.isEmpty {
                setQuizCompleted(userScores: userScores)
            }
        }
    }

    func setQuizCompleted(userScores: [QuizScore]) {
        let sortedScores = userScores.sorted { $0.puntaje_quiz > $1.puntaje_quiz }
        let sortedZones = sortedScores.map { $0.zona }
        defaults.set(sortedZones, forKey: "sortedZones")
        hasAnsweredQuiz = true
        defaults.set(true, forKey: "hasAnsweredQuiz")
    }
    
    func fetchExhibitionData(exhibition: String) async -> Exhibition? {
        if exhibition.isEmpty{
            errorMessage = "Se requiere el nombre de la exhibición"
            return nil
        }
        let url = URL(string: "https://papalote-backend.onrender.com/api/exhibicion/\(exhibition)")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            if let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) {
                let exhibition = try JSONDecoder().decode(Exhibition.self, from: data)
                return exhibition
            } else {
                print("Failed to fetch exhibition. Status code:", (response as? HTTPURLResponse)?.statusCode ?? -1)
            }
        } catch {
            print("Error decoding response:", error.localizedDescription)
            errorMessage = "Hubo un error al obtener la información básica de la exhibición: \(error.localizedDescription)"
        }
        return nil
    }
    
    func fetchZoneData(zone: String) async -> Zone? {
        if zone.isEmpty{
            errorMessage = "Se requiere el nombre de la zona"
            return nil
        }
        let url = URL(string: "https://papalote-backend.onrender.com/api/zona/\(zone)")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            if let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) {
                let zone = try JSONDecoder().decode(Zone.self, from: data)
                return zone
            } else {
                print("Failed to fetch zone. Status code:", (response as? HTTPURLResponse)?.statusCode ?? -1)
            }
        } catch {
            print("Error decoding response:", error.localizedDescription)
            errorMessage = "Hubo un error al obtener la información básica de la zona: \(error.localizedDescription)"
        }
        return nil
    }
    
    func fetchExhibitionActivity(exhibition: String) async -> [Page] {
        if exhibition.isEmpty{
            errorMessage = "Se requiere el nombre de la exhibición"
            return []
        }
        let url = URL(string: "https://papalote-backend.onrender.com/api/paginas/\(exhibition)/")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            if let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) {
                let activity = try JSONDecoder().decode([Page].self, from: data)
                return activity
            } else {
                print("Failed to . Status code:", (response as? HTTPURLResponse)?.statusCode ?? -1)
            }
        } catch {
            print("Error decoding response:", error.localizedDescription)
            errorMessage = "Hubo un error al obtener los resultados del quiz: \(error.localizedDescription)"
        }
        return []
    }
    
    func fetchNotifications() async -> [Announcement] {
        let url = URL(string: "https://papalote-backend.onrender.com/api/notificaciones/")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            print(data)
            if let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) {
                let notifications = try JSONDecoder().decode([Announcement].self, from: data)
                return notifications
            } else {
                print("Failed to . Status code:", (response as? HTTPURLResponse)?.statusCode ?? -1)
            }
        } catch {
            print("Error decoding response:", error.localizedDescription)
            errorMessage = "Hubo un error al obtener las notificaciones: \(error.localizedDescription)"
        }
        return []
    }
    
    func modifyProfile(nombre: String, apellido: String, fecha: Date, password: String, correo: String) async {
        let url = URL(string: "https://papalote-backend.onrender.com/api/usuarios/\(userID)/")!
        var request = URLRequest(url: url)
        request.httpMethod = "PATCH"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateString = dateFormatter.string(from: fecha)
        
        let parameters: [String: String] = [
            "nombre": nombre,
            "apellido": apellido,
            "fecha_nacimiento": dateString,
            "password_hash": password,
            "correo": correo
        ]
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: parameters)
            request.httpBody = jsonData
            
            let (data, response) = try await URLSession.shared.data(for: request)
            
            if let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) {
                if let json = try JSONSerialization.jsonObject(with: data) as? [String: Any] {
                    let defaults = UserDefaults.standard
                    defaults.set(json["id_usuario"] as? String ?? userID, forKey: "userID")
                    defaults.set(nombre, forKey: "nombre")
                    defaults.set(apellido, forKey: "apellido")
                    defaults.set(correo, forKey: "correo")
                    defaults.set(dateString, forKey: "fechaNacimiento")
                    
                    if let fotoPerfil = json["foto_perfil"] as? String {
                        defaults.set(fotoPerfil, forKey: "fotoPerfil")
                    }
                    if let fechaRegistro = json["fecha_registro"] as? String {
                        defaults.set(fechaRegistro, forKey: "fechaRegistro")
                    }
                    
                    print("Perfil actualizado exitosamente")
                } else {
                    errorMessage = "Error al procesar la respuesta del servidor"
                }
            } else {
                errorMessage = "Error en la actualización del perfil"
            }
        } catch {
            print("Error updating profile:", error.localizedDescription)
            errorMessage = "Hubo un error al modificar el perfil: \(error.localizedDescription)"
        }
    }
    
    
    
    func signOut() {
        selectedAuthView = "LogIn"
        userID = ""
        isAuthenticated = false
        hasRecentAccessCode = false
        hasAnsweredQuiz = false
        resetAllDefaults()
        selectedView = "Home"

    }
    
    func clearError() {
        errorMessage = nil
    }
}
