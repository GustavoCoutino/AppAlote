//
//  ActivityView.swift
//  AppAlote
//
//  Created by Miguel Mendoza on 11/10/24.
//

import SwiftUI

struct ActivityView: View {
    @EnvironmentObject var userManager: UserManager
    @State private var currentPage = 0
    @State private var rating: Int = 0
    @State private var feedback: String = ""
    var body: some View {
        VStack {
            ProgressView(value: Double(currentPage + 1), total: 3)
                .progressViewStyle(LinearProgressViewStyle(tint: .yellow))
                .scaleEffect(x: 1, y: 3, anchor: .center)
                .padding()
            
            if currentPage == 0 {
                PageView(
                    title: "¿Qué crees que hay debajo de la tierra?",
                    description: "El suelo se forma de manera vertical a través del tiempo, formando capas a las que se les conoce como horizontes.",
                    imageName: "img_1"
                )
            } else if currentPage == 1 {
                PageView(
                    title: "Instrucciones:",
                    description: "Observar los cinco perfiles de suelo montados en nichos de acrílico y deslizar una regla sobre ellos para identificar las diferentes divisiones de color en las capas del suelo.",
                    imageName: "img-2"
                )
            } else {
                FinalPageView(rating: $rating, feedback: $feedback)
            }
            
            HStack {
                if currentPage > 0 {
                    Button("Retroceder") {
                        currentPage -= 1
                    }
                    .buttonStyle(NavigationButtonStyle())
                }
                
                Spacer()
                
                Button("Siguiente") {
                    if currentPage < 2 {
                        currentPage += 1
                    }
                }
                .buttonStyle(NavigationButtonStyle())
            }
            .padding()
        }
        .padding()
        .onAppear{
            print("Hola")
        }
    }
}

#Preview {
    ActivityView().environmentObject(UserManager())
}
