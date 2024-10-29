//
//  UserManager.swift
//  AppAlote
//
//  Created by Gustavo Coutiño on 28/10/24.
//
import Foundation
import SwiftUI

class UserManager: ObservableObject {
    @Published var isAuthenticated = false
    @Published var showErrorMessage = false
    @Published var errorMessage = ""
    
    private let mockUsers = [
        ["correo": "gustavo@gmail.com", "password": "123"],
        ["correo": "test@example.com", "password": "test123"]
    ]
    private let validCode = "123456"
    
    func login(correo: String, password: String) {
        if let user = mockUsers.first(where: { $0["correo"] == correo && $0["password"] == password }) {
            isAuthenticated = true
            showErrorMessage = false
        } else {
            isAuthenticated = false
            errorMessage = "Correo o contraseña incorrecta"
            showErrorMessage = true
        }
    }
    
    func validateCode(_ code: String) -> Bool {
        return code == validCode
    }
    
    func logout() {
        isAuthenticated = false
    }
}
