//
//  LogrosView.swift
//  AppAlote
//
//  Created by Miguel Mendoza on 31/10/24.
//

import SwiftUI

struct LogrosView: View {
    
    @State private var achievements: [Desafios] = []
    @EnvironmentObject var userManager: UserManager
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                ForEach(achievements) { achievement in
                    HStack {
                        AsyncImage(url: URL(string: achievement.img_desafio)) { image in image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 70, height: 70)
                                .padding()
                                .cornerRadius(10)
                        } placeholder: {
                            ProgressView()
                        }
                        
                        VStack(alignment: .leading) {
                            Text(achievement.nombre_desafio)
                                .font(.headline)
                            Text("Visita \(achievement.valor_meta) exhibiciones")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                            
                            ProgressView(value: Float(achievement.progreso_actual), total: Float(achievement.progreso_actual))
                                .progressViewStyle(LinearProgressViewStyle(tint: Color.green))
                                .frame(width: 150)
                            
                        }
                        .padding(.horizontal)
                    }
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 5)
                }
            }
            .padding()
            Spacer().frame(height: 120)
        }
        .onAppear {
            Task {
                achievements = await userManager.fetchAchievements()
            }
        }
    }
}


