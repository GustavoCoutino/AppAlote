//
//  ViewController.swift
//  AppAlote
//
//  Created by Miguel Mendoza on 28/10/24.
//

import SwiftUI

struct ViewController: View {
    @State private var selectedView: String = "Home"
    @State private var quizAnswered = false
    var body: some View {
        if quizAnswered {
            ZStack {
                switch selectedView {
                case "Home":
                    HomeView()
                case "Map":
                    MapView()
                case "Code":
                    EmptyView()
                case "Profile":
                    EmptyView()
                default:
                    HomeView()
                }
                Navbar(selectedView: $selectedView)
            }
        } else {
            QuizView(completed: $quizAnswered)
        }
    }
}

#Preview {
    ViewController()
}
