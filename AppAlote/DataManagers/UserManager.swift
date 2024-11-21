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
    @Published var profilePicture = ""
    @Published var name = ""
    @Published var lastName = ""
    @Published var dateOfBirth = ""
    @Published var email = ""
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
            if response is HTTPURLResponse {
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
                        profilePicture = fotoPerfil
                    }
                    if let tarjeta = json["tarjeta"] as? String {
                        defaults.set(tarjeta, forKey: "tarjeta")
                    }
                        self.userID = defaults.string(forKey: "userID") ?? ""
                        self.name = nombre
                        self.lastName = apellido
                        self.email = correo
                        self.dateOfBirth = fechaNacimiento
                        
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
            if response is HTTPURLResponse {
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
                        if let tarjeta = json["tarjeta"] as? String {
                            defaults.set(tarjeta, forKey: "tarjeta")
                        }
                        
                        userID = defaults.string(forKey: "userID") ?? ""
                        self.name = nombre
                        self.lastName = apellido
                        self.email = correo
                        self.dateOfBirth = fechaNacimiento
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
                // Debug: Print raw JSON response
                if let jsonString = String(data: data, encoding: .utf8) {
                    print("Raw JSON Response: \(jsonString)")
                }
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
    
    func loadData() async {
        if !userID.isEmpty {
            let url = URL(string: "https://papalote-backend.onrender.com/api/usuarios/\(userID)/")!
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            do {
                let (data, response) = try await URLSession.shared.data(for: request)
                if let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) {
                    let user = try JSONDecoder().decode(User.self, from: data)
                    defaults.set(user.nombre, forKey: "nombre")
                    name = user.nombre
                    defaults.set(user.apellido, forKey: "apellido")
                    lastName = user.apellido
                    defaults.set(user.correo, forKey: "correo")
                    email = user.correo
                    defaults.set(user.fecha_nacimiento, forKey: "fechaNacimiento")
                    dateOfBirth = user.fecha_nacimiento
                    defaults.set(user.foto_perfil, forKey: "fotoPerfil")
                    profilePicture = user.foto_perfil
                } else {
                    print("Failed to . Status code:", (response as? HTTPURLResponse)?.statusCode ?? -1)
                }
            } catch {
                print("Error decoding response:", error.localizedDescription)
                errorMessage = "Hubo un error al obtener datos del usuario: \(error.localizedDescription)"
            }
        }
    }
    
    func submitOpinion(stars: Int, comment: String, exhibitionID: Int) async {
        let url = URL(string: "https://papalote-backend.onrender.com/api/opiniones/")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateString = dateFormatter.string(from: Date())
        
        let payload: [String: Any] = [
            "calificacion": stars,
            "descripcion": comment,
            "fecha_opinion": dateString,
            "usuario": userID,
            "exhibicion": exhibitionID
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
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                print("Opinion submitted successfully.")
            } else {
                print("Server Error: \(response)")
            }
        } catch {
            print("Network Error: \(error.localizedDescription)")
        }
    }
    
    /*
    func submitScan(stars: Int, comment: String, exhibitionID: Int) async {
        let url = URL(string: "https://papalote-backend.onrender.com/api/escaneos/")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateString = dateFormatter.string(from: Date())
        
        let payload: [String: Any] = [
            "calificacion": stars,
            "descripcion": comment,
            "fecha_opinion": dateString,
            "usuario": userID,
            "exhibicion": exhibitionID
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
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                print("Opinion submitted successfully.")
            } else {
                print("Server Error: \(response)")
            }
        } catch {
            print("Network Error: \(error.localizedDescription)")
        }
    }
    */
    
    func modifyProfile(nombre: String, apellido: String, fecha: Date, correo: String) async {
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
                    
                    name = nombre
                    lastName = apellido
                    email = correo
                    dateOfBirth = dateString
                    
                    
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
    
    func updateTarjeta(imagen: String) async {
        let url = URL(string: "https://papalote-backend.onrender.com/api/usuarios/\(userID)/")!
        var request = URLRequest(url: url)
        request.httpMethod = "PATCH"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        
        
        do {
            let jsonPayload: [String: Any] = ["imagen": imagen]
            let jsonData = try JSONSerialization.data(withJSONObject: jsonPayload, options: [])
            request.httpBody = jsonData
            
            let (data, response) = try await URLSession.shared.data(for: request)
            
            if let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) {
                if let json = try JSONSerialization.jsonObject(with: data) as? [String: Any] {
                    let defaults = UserDefaults.standard
                    defaults.set(imagen, forKey: "tarjeta")
                    print("Tarjeta actualizada exitosamente")
                } else {
                    errorMessage = "Error al procesar la respuesta del servidor"
                }
            } else {
                errorMessage = "Error en la actualización de la tarjeta"
            }
        } catch {
            print("Error updating profile:", error.localizedDescription)
            errorMessage = "Hubo un error al modificar la tarjeta: \(error.localizedDescription)"
        }
    }
    
    
    func uploadProfilePhoto(imageData: Data) {
            guard let url = URL(string: "https://papalote-backend.onrender.com/api/usuarios/\(userID)/") else {
                print("Invalid URL")
                return
            }
            
            let boundary = UUID().uuidString
            
            var request = URLRequest(url: url)
            request.httpMethod = "PATCH"
            request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
            
            var body = Data()
            body.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
            body.append("Content-Disposition: form-data; name=\"foto_perfil\"; filename=\"photo.jpg\"\r\n".data(using: .utf8)!)
            body.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8)!)
            body.append(imageData)
            body.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)
            
            request.httpBody = body
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                DispatchQueue.main.async {
                    
                    if let error = error {
                        print("Error: \(error.localizedDescription)")
                        return
                    }
                    
                    guard let httpResponse = response as? HTTPURLResponse else {
                        print("No HTTP Response")
                        return
                    }
                    
                    if (200...299).contains(httpResponse.statusCode) {
                        print("Upload successful")
                        if let data = data,
                           let responseDict = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
                           let newPhotoUrl = responseDict["foto_perfil"] as? String {
                            UserDefaults.standard.set(newPhotoUrl, forKey: "fotoPerfil")
                            self.profilePicture = newPhotoUrl
                        }
                    } else {
                        print("Upload failed with status code: \(httpResponse.statusCode)")
                    }
                }
            }
            task.resume()
        }
    
    func fetchAchievements() async -> [Desafios] {
        let url = URL(string: "https://papalote-backend.onrender.com/api/desafios-usuario/\(userID)/")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
                
            if let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) {
                let decoder = JSONDecoder()
                let challenges = try decoder.decode([Desafios].self, from: data)
                return challenges
            } else {
                print("Failed to . Status code:", (response as? HTTPURLResponse)?.statusCode ?? -1)
            }
        } catch {
            print("Error decoding response:", error.localizedDescription)
            errorMessage = "Hubo un error al obtener los desafios: \(error.localizedDescription)"
        }
        return []
    }
    
    func fetchInsignias() async -> [Insignias] {
        let url = URL(string: "https://papalote-backend.onrender.com/api/insignias/\(userID)/")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
                
            if let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) {
                let decoder = JSONDecoder()
                let badges = try decoder.decode([Insignias].self, from: data)
                return badges
            } else {
                print("Failed to . Status code:", (response as? HTTPURLResponse)?.statusCode ?? -1)
            }
        } catch {
            print("Error decoding response:", error.localizedDescription)
            errorMessage = "Hubo un error al obtener las insignias: \(error.localizedDescription)"
        }
        return []
    }
    
    func fetchTarjetas() async -> [Tarjetas] {
        let url = URL(string: "https://papalote-backend.onrender.com/api/tarjetas/\(userID)/")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
                
            if let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) {
                let decoder = JSONDecoder()
                let cards = try decoder.decode([Tarjetas].self, from: data)
                return cards
            } else {
                print("Failed to . Status code:", (response as? HTTPURLResponse)?.statusCode ?? -1)
            }
        } catch {
            print("Error decoding response:", error.localizedDescription)
            errorMessage = "Hubo un error al obtener las tarjetas: \(error.localizedDescription)"
        }
        return []
    }
    
    
    func signOut() {
        selectedAuthView = "LogIn"
        userID = ""
        profilePicture = ""
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
