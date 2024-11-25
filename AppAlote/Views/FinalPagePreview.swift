//
//  FinalPagePreview.swift
//  AppAlote
//
//  Created by Miguel Mendoza on 11/17/24.
//

import SwiftUI

struct FinalPageView: View {
    @Binding var rating: Int
    @Binding var feedback: String
    @EnvironmentObject var userManager: UserManager

    var body: some View {
        VStack {
            VStack(spacing: 30){
                Text("¡Felicidades! Has completado la actividad, ¿podrías evaluarla en una escala del 1 al 5?")
                    .font(.system(size: 18))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                HStack {
                    ForEach(1...5, id: \.self) { star in
                        Image(systemName: star <= rating ? "star.fill" : "star")
                            .foregroundStyle(.yellow)
                            .font(.system(size: 35))
                            .onTapGesture {
                                rating = star
                            }
                        
                    }
                }
            }
            .frame(maxWidth: 400)
            .padding(.bottom, 50)

            
            
            VStack(spacing: 30) {
                Text("Escribe alguna sugerencia o idea para mejorar esta actividad.")
                    .font(.system(size: 18))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
            }
            .padding(.bottom, 20)
            TextEditor(text: $feedback)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.yellow, lineWidth: 1)
                )
                .frame(height: 150)
                .frame(maxWidth: .infinity)
            
            
        }
        .padding()
        .frame(maxWidth: 400)
        .frame(maxHeight: .infinity)
        .frame(maxWidth: .infinity)
        .background(Color.yellow.opacity(0.1))
        .cornerRadius(10)
    }
}

#Preview {
    FinalPageView(rating: .constant(0), feedback: .constant("")).environmentObject(UserManager())
}
