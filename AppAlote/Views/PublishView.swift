//
//  PublishView.swift
//  AppAlote
//
//  Created by Gustavo Coutiño on 22/11/24.
//
import SwiftUI
import PhotosUI

struct PublishView: View {
    @State private var isLoading = false
    @State private var selectedExhibitionId: Int? = nil
    @State private var comment = ""
    @State private var selectedImage: UIImage? = nil
    @State private var selectedItem: PhotosPickerItem?
    @State private var showAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
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
                        if let url = URL(string: userManager.profilePicture) {
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

                        Text("\(userManager.name + " " + userManager.lastName)")
                            .font(.headline)
                            .padding(.leading, 10)

                        Spacer()

                        Button(action: {
                            if comment.isEmpty && selectedImage == nil {
                                alertMessage = "La publicacion requiere al menos un comentario o una imagen"
                                alertTitle = "Datos faltantes"
                                showAlert = true
                                return
                            }

                            isLoading = true
                            Task {
                                let imageData = selectedImage?.jpegData(compressionQuality: 0.8)
                                await userManager.uploadPost(imageData: imageData, exhibitionId: selectedExhibitionId ?? 0, comment: comment)
                                isLoading = false
                                alertMessage = "Tu publicacion esta en revision para ser publicada"
                                alertTitle = "Publicacion exitosa"
                                showAlert = true
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
        }.alert(alertTitle, isPresented: $showAlert) {
            Button("OK", role: .cancel) {}
        } message: {
            Text(alertMessage)
        }
        
    }
}
