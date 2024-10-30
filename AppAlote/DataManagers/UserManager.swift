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
    
    private let defaults = UserDefaults.standard
    
    init() {
        resetAllDefaults() // DELETE THIS LINE IN PRODUCTION
        loadStoredSession()
    }
    
    func resetAllDefaults() {
        if let appDomain = Bundle.main.bundleIdentifier {
            defaults.removePersistentDomain(forName: appDomain)
        }
    }
    
    private func loadStoredSession() {
        userID = defaults.string(forKey: "userID") ?? ""
        isAuthenticated = !userID.isEmpty
        hasRecentAccessCode = false // TODO: check if its the same as in the DB
        hasAnsweredQuiz = defaults.bool(forKey: "hasAnsweredQuiz")
        print(userID)
    }
    
    func signIn(name: String, date: Date, email: String, password: String) {
        // TODO: create user
        self.userID = "1" // TODO: get the user ID
        defaults.set(userID, forKey: "userID")
        isAuthenticated = true
    }
    
    func logIn(email: String, password: String) {
        
        if email.isEmpty || password.isEmpty {
            errorMessage = "Los campos del correo electónico y contraseña son requeridos."
            return
        }
        
        // TODO: verify email and pasword
    
        self.userID = "1" // TODO: get the user ID
        defaults.set(userID, forKey: "userID")
        isAuthenticated = true
        print(self.userID, isAuthenticated)
    }
    
    func enterAccessCode(_ code: String) {
        hasRecentAccessCode = true // TODO: check if the access code is the same one as in DB
        defaults.set(true, forKey: "accessCode")
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
