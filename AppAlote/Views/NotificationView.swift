//
//  NotificationView.swift
//  AppAlote
//
//  Created by Miguel Mendoza on 11/20/24.
//

import SwiftUI

struct NotificationView: View {
    let notification : Announcement
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: "megaphone.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 50)
                .foregroundColor(.black)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(notification.titulo_es)
                    .font(.headline)
                    .foregroundColor(.black)
                
                Text(notification.descripcion_es)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            
            Spacer()
        }
        .padding()
        .background(Color(UIColor.systemGroupedBackground))
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
            
    }
}

#Preview {
    NotificationView(notification: Announcement(id: 1, fecha_creacion: "2024-11-12T19:48:56.493478Z", titulo_es: "Desafíos Actualizados", titulo_en: "Challenges Updated", descripcion_es: "¡Hemos añadido nuevos desafíos emocionantes! Completa los desafíos para ganar recompensas únicas.", descripcion_en: "We've added new exciting challenges! Complete them to earn unique rewards."))
}
