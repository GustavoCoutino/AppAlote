//
//  TabButton.swift
//  AppAlote
//
//  Created by Miguel Mendoza on 31/10/24.
//

import SwiftUI

struct TabButton: View {
    let title: String
    let isSelected: Bool
    var body: some View {
        VStack {
            Text(title)
                .font(.headline)
                .padding(.horizontal)
                .padding(.vertical, 8)
                .background(isSelected ? Color(red: 210/255, green: 223/255, blue: 73/255) : Color.clear)
                .cornerRadius(8)
                .foregroundColor(isSelected ? .black : .gray)
            
            if isSelected {
                Rectangle()
                    .fill(Color(red: 210/255, green: 223/255, blue: 73/255))
                    .frame(height: 4)
            } else {
                Rectangle()
                    .fill(Color.clear)
                    .frame(height: 4)
            }
        }
        .animation(.easeInOut, value: isSelected)
    }
}

#Preview {
    TabButton(title: "Hola", isSelected: false)
}
