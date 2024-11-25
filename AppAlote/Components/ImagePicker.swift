//
//  ImagePicker.swift
//  AppAlote
//
//  Created by Gustavo Coutiño on 22/11/24.
//

import SwiftUI
import PhotosUI


struct ImagePicker: View {
    @Binding var selectedImage: UIImage?
    @State private var isPhotosPickerPresented = false
    @State private var selectedItem: PhotosPickerItem?
    
    var body: some View {
        VStack {
            if let selectedImage = selectedImage {
                Button(action: {
                    isPhotosPickerPresented = true
                }) {
                    Image(uiImage: selectedImage)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 200)
                        .cornerRadius(10)
                }
            } else {
                Button(action: {
                    isPhotosPickerPresented = true
                }) {
                    VStack {
                        Image(systemName: "photo.on.rectangle")
                            .resizable()
                            .frame(width: 50, height: 50)
                        Text("Agregar imagen")
                            .foregroundColor(.black)
                            .font(.subheadline)
                    }
                    .frame(maxWidth: .infinity, minHeight: 150)
                    .background(Color.gray.opacity(0.3))
                    .cornerRadius(10)
                }
            }
        }
        .padding(.horizontal, 10)
        .photosPicker(isPresented: $isPhotosPickerPresented,
                      selection: $selectedItem,
                      matching: .images)
        .onChange(of: selectedItem) { newItem in
            Task {
                if let data = try? await newItem?.loadTransferable(type: Data.self) {
                    if let image = UIImage(data: data) {
                        selectedImage = image
                    }
                }
            }
        }
    }
}
