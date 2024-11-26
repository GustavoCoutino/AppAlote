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
    @State private var shouldDismiss = false
    @EnvironmentObject var userManager: UserManager
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ZStack(alignment: .top) {
            VStack(spacing: 20) {
                VStack(spacing: 20) {
                    HStack {
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
                                let isSuccess = await userManager.uploadPost(imageData: imageData, exhibitionId: selectedExhibitionId ?? 0, comment: comment)
                                isLoading = false

                                if isSuccess {
                                    alertMessage = "Tu publicacion esta en revision para ser publicada"
                                    alertTitle = "Publicacion exitosa"
                                    shouldDismiss = true
                                } else {
                                    alertMessage = "Ocurrió un error al publicar. Inténtalo de nuevo."
                                    alertTitle = "Error"
                                }
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
            Button("OK", role: .cancel) {
                if shouldDismiss {
                    dismiss()
                }
            }
        } message: {
            Text(alertMessage)
        }
    }
}

#Preview {
    PublishView().environmentObject(UserManager())
}
