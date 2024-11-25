//
//  BannerViewPost.swift
//  AppAlote
//
//  Created by Miguel Mendoza on 11/25/24.
//


import SwiftUI

struct BannerViewPost: View {
    @EnvironmentObject var userManager: UserManager
    let post : Post
    @State private var isExhibitionSelected: Bool = false
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 10){
                HStack {
                    
                    if let pp = post.foto_perfil{
                        if let url = URL(string: pp) {
                            AsyncImage(url: url) { phase in
                                switch phase {
                                case .empty:
                                    ProgressView()
                                        .frame(width: 50, height: 50)
                                        .padding(.leading, 20)
                                case .success(let image):
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 50, height: 50)
                                        .clipShape(Circle())
                                        .padding(.leading, 20)
                                default:
                                    Image(systemName: "person.circle.fill")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 50, height: 50)
                                        .padding(.leading, 20)
                                        .foregroundColor(.black)
                                }
                            }
                        }
                    } else {
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                            .padding(.leading, 20)
                            .foregroundColor(.black)
                    }
                    
                    Text(post.nombre)
                        .font(.headline)
                        .bold()
                        .padding()
                        .background(
                            Color(red: 210/255, green: 223/255, blue: 73/255)
                        )
                        .clipShape(.rect(cornerRadius: 15))
                        .padding(.leading, 10)
                    
                    Spacer()
                    
                    
                    if let name = post.nombre_exhibicion {
                        Button(action: {
                            isExhibitionSelected = true
                        }) {
                            ZStack {
                                Circle()
                                    .fill(.black)
                                    .frame(width: 24, height: 24)
                                
                                Image(systemName: "mappin.circle.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 50, height: 50)
                                    .foregroundStyle(Color(red: 210/255, green: 223/255, blue: 73/255))
                            }
                            .shadow(radius: 5)
                            .padding(.trailing, 15)
                        }
                        .navigationDestination(isPresented: $isExhibitionSelected) {
                            ExhibitionView(name: name)
                        }
                    }
                    
            
                }
                .background(
                    backgroundView(for: post.tarjeta)
                )
                .frame(height: 100)
                
                if let description = post.descripcion{
                    if !description.isEmpty {
                        Text(description)
                            .padding(.leading, 10)
                            .padding(.bottom, 25)
                            .bold()
                    }
                }
                
                if let img = post.img {
                    if let url = URL(string: img) {
                        AsyncImage(url: url) { phase in
                            switch phase {
                            case .empty:
                                HStack{
                                    Spacer()
                                    ProgressView()
                                        .frame(height: 100)
                                    Spacer()
                                }
                                
                                
                            case .success(let image):
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .clipShape(RoundedRectangle(cornerRadius: 15))
                            default:
                                Image(systemName: "photo")
                                    .resizable()
                                    .scaledToFit()
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                }
                
            }
            .frame(maxWidth: 500)
            .background(
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color(red: 210/255, green: 223/255, blue: 73/255).opacity(0.2))
                    .shadow(radius: 5)
            )
            .padding(.horizontal, 30)
            
        }
    }

    // Helper function for consistent background handling
    @ViewBuilder
    private func backgroundView(for banner: String?) -> some View {
        if let banner = banner, let url = URL(string: banner) {
            AsyncImage(url: url) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 100)
                        .clipped()
                        .clipShape(.rect(cornerRadius: 15))
                default:
                    RoundedRectangle(cornerRadius: 15)
                        .fill(Color(red: 210/255, green: 223/255, blue: 73/255))
                        .frame(height: 100)
                }
            }
        } else {
            RoundedRectangle(cornerRadius: 15)
                .fill(Color(red: 210/255, green: 223/255, blue: 73/255))
                .frame(height: 100)
                .shadow(radius: 5)
        }
    }
}

#Preview {
    BannerViewPost(post: Post(id: 1, id_usuario: "jfirjfijrij", nombre: "Lionel", foto_perfil: "https://fcb-abj-pre.s3.amazonaws.com/img/jugadors/MESSI.jpg", tarjeta: "https://upload.wikimedia.org/wikipedia/commons/9/9c/Cinderella_Castle_Perspectives_-_Banner_view.png", descripcion: "Este es mi primer post.", img: "https://fifpro.org/media/5chb3dva/lionel-messi_imago1019567000h.jpg?rxy=0.32986930611281567,0.18704579979466449&rnd=133378758718600000", nombre_exhibicion: "ESTRATOS") ).environmentObject(UserManager())
}

/*
 
 name: "Miguel", lastName: "Mendoza", profilePicture: "https://fcb-abj-pre.s3.amazonaws.com/img/jugadors/MESSI.jpg", banner: "https://upload.wikimedia.org/wikipedia/commons/9/9c/Cinderella_Castle_Perspectives_-_Banner_view.png", description: "Este es mi primer post", image: "https://fifpro.org/media/5chb3dva/lionel-messi_imago1019567000h.jpg?rxy=0.32986930611281567,0.18704579979466449&rnd=133378758718600000"
 */
