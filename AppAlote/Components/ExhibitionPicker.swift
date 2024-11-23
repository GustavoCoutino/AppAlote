//
//  ExhibitionPicker.swift
//  AppAlote
//
//  Created by Gustavo Coutiño on 22/11/24.
//

import SwiftUI

struct ExhibitionPicker: View {
    @Binding var selectedExhibition: Int?
    @State private var exhibitionNames: [ExhibitionName] = []
    @EnvironmentObject var userManager: UserManager
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Exhibición relacionada")
                .font(.subheadline)
                .foregroundColor(.purple)
            Picker("Selecciona una opción", selection: $selectedExhibition) {
                Text("Ninguna").tag(nil as Int?)
                ForEach(exhibitionNames, id: \.id) { exhibition in
                    Text(exhibition.nombre).tag(exhibition.id as Int?)
                }
            }
            .pickerStyle(MenuPickerStyle())
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.yellow.opacity(0.4))
            .cornerRadius(8)
        }
        .padding(.horizontal, 10)
        .onAppear() {
            Task {
                exhibitionNames = await userManager.getAllExhibitionNames()
            }
        }
    }
}

