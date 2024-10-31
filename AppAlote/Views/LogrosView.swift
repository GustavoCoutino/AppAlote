//
//  LogrosView.swift
//  AppAlote
//
//  Created by Miguel Mendoza on 31/10/24.
//

import SwiftUI

struct LogrosView: View {
    
    struct Achievement: Identifiable {
        let id = UUID()
        let title: String
        let level: String
        let currentProgress: Int
        let totalProgress: Int
        let imageName: String
        let color: Color
    }
    
    let achievements: [Achievement] = [
        Achievement(title: "Explorador", level: "1", currentProgress: 9, totalProgress: 9, imageName: "logro1", color: Color.yellow),
        Achievement(title: "Explorador", level: "2", currentProgress: 5, totalProgress: 10, imageName: "logro2", color: Color.yellow),
        Achievement(title: "Explorador", level: "3", currentProgress: 8, totalProgress: 10, imageName: "logro1", color: Color.yellow),
        Achievement(title: "Explorador", level: "4", currentProgress: 8, totalProgress: 10, imageName: "logro2", color: Color.yellow),
        Achievement(title: "Explorador", level: "5", currentProgress: 8, totalProgress: 10, imageName: "logro1", color: Color.yellow),
        Achievement(title: "Explorador", level: "6", currentProgress: 8, totalProgress: 10, imageName: "logro2", color: Color.yellow),
        Achievement(title: "Explorador", level: "7", currentProgress: 8, totalProgress: 10, imageName: "logro1", color: Color.yellow),
    ]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                ForEach(achievements) { achievement in
                    HStack {
                        Image(achievement.imageName) // Utiliza la imagen personalizada
                            .resizable()
                            .frame(width: 70, height: 70)
                            .padding()
                            .background(achievement.color)
                            .cornerRadius(10)
                        
                        VStack(alignment: .leading) {
                            Text(achievement.title)
                                .font(.headline)
                            Text("Visita \(achievement.totalProgress) exhibiciones")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                            
                            ProgressView(value: Float(achievement.currentProgress), total: Float(achievement.totalProgress))
                                .progressViewStyle(LinearProgressViewStyle(tint: achievement.color))
                                .frame(width: 150)
                            
                            HStack {
                                Text("Nivel \(achievement.level)")
                                    .font(.caption)
                                    .fontWeight(.bold)
                                    .foregroundColor(.gray)
                                Spacer()
                                Text("\(achievement.currentProgress)/\(achievement.totalProgress)")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                        }
                        .padding(.leading)
                    }
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 5)
                    .padding(.horizontal)
                }
            }
            .padding()
        }
    }
}

#Preview {
    LogrosView()
}
