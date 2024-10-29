//
//  ViewController.swift
//  AppAlote
//
//  Created by Miguel Mendoza on 28/10/24.
//

import SwiftUI

struct ViewController: View {
    @State private var selectedView: String = "Home"
    var body: some View {
        ZStack {
            switch selectedView {
            case "Home":
                HomeView()
            case "Map":
                MapView()
            case "Code":
                EmptyView()
            case "Quiz":
                QuizView()
            case "Profile":
                EmptyView()
            default:
                HomeView()
            }
            Navbar(selectedView: $selectedView)
        }
    }
}

#Preview {
    ViewController()
}
