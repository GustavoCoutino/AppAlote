//
//  AppAloteApp.swift
//  AppAlote
//
//  Created by Gustavo Coutiño on 15/10/24.
//

import SwiftUI

@main
struct AppAloteApp: App {
    @StateObject var userManager = UserManager()
    var body: some Scene {
        WindowGroup {
            ViewController()
                .environmentObject(userManager)
                .environment(\.sizeCategory, .large)
        }
    }
}
