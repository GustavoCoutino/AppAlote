//
//  HeaderView.swift
//  AppAlote
//
//  Created by Gustavo Coutiño on 21/11/24.
//

import SwiftUI

struct HeaderView: View {
    var body: some View {
        VStack {
            HStack {
                
                
            }
            .padding(.top, 42)
        }
        .frame(width: UIScreen.main.bounds.size.width)
        .padding(.vertical, 20)
        .background(Color(red: 210/255, green: 223/255, blue: 73/255))
        .frame(maxHeight: UIScreen.main.bounds.size.height, alignment: .top)
        .ignoresSafeArea()
    }
}

#Preview {
    HeaderView()
}
