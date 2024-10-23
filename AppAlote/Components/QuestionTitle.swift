//
//  QuestionTitle.swift
//  AppAlote
//
//  Created by Gustavo Coutiño on 23/10/24.
//

import SwiftUI

struct QuestionTitle: View {
    var title: String

    var body: some View {
        Text(title)
            .font(.headline)
            .padding(.top, 10)
            .multilineTextAlignment(.center)
    }
}

#Preview {
    QuestionTitle(title: "De estos colores, ¿cuál es el que más te gusta?")
}

