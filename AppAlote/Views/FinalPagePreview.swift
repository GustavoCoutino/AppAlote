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
        VStack(alignment: .leading, spacing: 20) {
            Text("¡Felicidades! Has completado la actividad, ¿podrías evaluarla en una escala del 1 al 5?")
                .font(.headline)
            
            HStack {
                ForEach(1...5, id: \.self) { star in
                    Image(systemName: star <= rating ? "star.fill" : "star")
                        .foregroundColor(.yellow)
                        .onTapGesture {
                            rating = star
                        }
                }
            }
            Text("Escribe alguna sugerencia o idea para mejorar esta actividad.")
                .font(.headline)
            TextField("Sugerencia", text: $feedback)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            Spacer()
        }
        .padding()
        .background(Color(UIColor.systemGreen).opacity(0.1))
        .cornerRadius(10)
    }
}

#Preview {
    FinalPageView(rating: .constant(3), feedback: .constant("")).environmentObject(UserManager())
}
