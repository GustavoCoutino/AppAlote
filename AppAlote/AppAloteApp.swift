//
//  AppAloteApp.swift
//  AppAlote
//
//  Created by Gustavo Coutiño on 15/10/24.
//

import SwiftUI

@main
struct AppAloteApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(UserManager())
        }
    }
}
