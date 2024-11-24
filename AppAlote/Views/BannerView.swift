//
//  BannerView.swift
//  AppAlote
//
//  Created by Miguel Mendoza on 11/22/24.
//

import SwiftUI

struct BannerView: View {
    @EnvironmentObject var userManager: UserManager
    @State var name : String = ""
    @State var lastName : String = ""
    @State var profilePicture : String = ""
    
    var body: some View {
        HStack {
            if let url = URL(string: profilePicture) {
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
            if !name.isEmpty && !lastName.isEmpty {
                Text("\(name) \(lastName)")
                .font(.headline)
                .bold()
                .padding()
                .background(
                    Color(red: 210/255, green: 223/255, blue: 73/255)
                )
                .clipShape(.rect(cornerRadius: 15))
                .padding(.leading, 10)
            }
            


            Spacer()
        }
        .background(
            backgroundView(for: UserDefaults.standard.string(forKey: "tarjeta") ?? "")
        )
        .frame(height: 100)
        .padding(.horizontal, 30)
        .padding(.top, 10)
        .onTapGesture {
            userManager.selectedView = "Profile"
        }
        .onAppear{
            name = UserDefaults.standard.string(forKey: "nombre") ?? "Invitado"
            lastName = UserDefaults.standard.string(forKey: "apellido") ?? ""
            profilePicture = UserDefaults.standard.string(forKey: "fotoPerfil") ?? "profile_picture"
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
                        .shadow(radius: 5)


                default:
                    RoundedRectangle(cornerRadius: 15)
                        .fill(Color(red: 210/255, green: 223/255, blue: 73/255))
                        .frame(height: 100)
                        .shadow(radius: 5)
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
    BannerView().environmentObject(UserManager())
}
