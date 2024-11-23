//
//  PublishView.swift
//  AppAlote
//
//  Created by Gustavo Coutiño on 22/11/24.
//
import SwiftUI
import PhotosUI

struct PublishView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var isLoading = false
    @State private var name = ""
    @State private var lastName = ""
    @State private var profilePicture = ""
    @State private var selectedExhibitionId: Int? = nil
    @State private var comment = ""
    @State private var selectedImage: UIImage? = nil
    @State private var selectedItem: PhotosPickerItem?
    @EnvironmentObject var userManager: UserManager

    var body: some View {
        ZStack(alignment: .top) {
            VStack(spacing: 0) {
                VStack {
                    HStack {
                        Spacer()
                        Text("Nueva publicación")
                            .font(.headline)
                            .foregroundColor(.black)
                        Spacer()
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 40)
                }
                .frame(height: 90)
                .background(Color(red: 210/255, green: 223/255, blue: 73/255))
                .ignoresSafeArea(edges: .top)

                Spacer()
            }

            VStack(spacing: 20) {
                VStack(spacing: 20) {
                    HStack {
                        if let url = URL(string: profilePicture) {
                            AsyncImage(url: url) { phase in
                                switch phase {
                                case .success(let image):
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 50, height: 50)
                                        .clipShape(Circle())
                                default:
                                    Image(systemName: "person.circle.fill")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 50, height: 50)
                                        .foregroundColor(.gray)
                                }
                            }
                        }

                        Text("\(name + " " + lastName)")
                            .font(.headline)
                            .padding(.leading, 10)

                        Spacer()

                        Button(action: {
                            if comment.isEmpty && selectedImage == nil {
                                return
                            }

                            isLoading = true
                            Task {
                                let imageData = selectedImage?.jpegData(compressionQuality: 0.8)
                                await userManager.uploadPost(imageData: imageData, exhibitionId: selectedExhibitionId ?? 0, comment: comment)
                                isLoading = false
                                dismiss()
                            }
                        }) {
                            if isLoading {
                                ProgressView()
                                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                            } else {
                                Text("Publicar")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .padding(.horizontal, 20)
                                    .padding(.vertical, 10)
                                    .background(Color.purple)
                                    .cornerRadius(10)
                            }
                        }
                    }
                    .padding(.horizontal, 10)

                    ExhibitionPicker(selectedExhibition: $selectedExhibitionId)

                    VStack(alignment: .leading, spacing: 8) {
                        Text("Escribe un comentario")
                            .font(.subheadline)
                            .foregroundColor(.purple)
                        TextEditor(text: $comment)
                            .frame(height: 100)
                            .padding(10)
                            .background(Color.yellow.opacity(0.4))
                            .cornerRadius(8)
                    }
                    .padding(.horizontal, 10)

                    ImagePicker(selectedImage: $selectedImage)
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 15)
                        .fill(Color.blue.opacity(0.2))
                        .shadow(radius: 5)
                )
                .padding(.horizontal, 20)
                .padding(.top, 60)
            }
        }
        .onAppear {
            name = UserDefaults.standard.string(forKey: "nombre") ?? "Invitado"
            lastName = UserDefaults.standard.string(forKey: "apellido") ?? ""
            profilePicture = UserDefaults.standard.string(forKey: "fotoPerfil") ?? ""
        }
    }
}
