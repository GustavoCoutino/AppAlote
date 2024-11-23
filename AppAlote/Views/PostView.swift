//
//  PostView.swift
//  AppAlote
//
//  Created by Gustavo Coutiño on 21/11/24.
//

import SwiftUI

struct PostView: View {
    let post: Post
    
    var body: some View {
        VStack {
            ProfileHeaderView(
                profilePicture: post.foto_perfil ?? "person.circle.fill",
                name: post.nombre,
                tarjeta: post.tarjeta ?? "",
                nombreExhibicion: post.nombre_exhibicion ?? ""
            )
            
            Text(post.descripcion ?? "")
                .font(.headline)
                .multilineTextAlignment(.leading)
                .foregroundColor(.black)
                
            
            AsyncImage(url: URL(string: post.img ?? "")) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(maxWidth: .infinity, minHeight: 200)
                    .padding(.horizontal, 10)
                    .cornerRadius(60)
            } placeholder: {
               Image("")
            }
            Spacer()
        }
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.blue.opacity(0.2))
                .shadow(radius: 5)
        )
        .padding(.horizontal, 10)
    }
}
