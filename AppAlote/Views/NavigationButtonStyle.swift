//
//  NavigationButtonStyle.swift
//  AppAlote
//
//  Created by Miguel Mendoza on 11/17/24.
//

import SwiftUI

struct NavigationButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(minWidth: 100)
            .padding()
            .background(Color(UIColor.systemGreen))
            .foregroundColor(.white)
            .cornerRadius(10)
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
    }
}

#Preview {
    Button("Ejemplo") {}
        .buttonStyle(NavigationButtonStyle())
        .padding()
}
