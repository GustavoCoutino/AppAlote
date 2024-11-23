//
//  LoadingView.swift
//  AppAlote
//
//  Created by Miguel Mendoza on 30/10/24.
//

import SwiftUI
import SDWebImageSwiftUI

struct LoadingView: View {
    @State var isLoading = true
    var body: some View {
        ZStack {
            
            Circle()
                .fill(Color.orange)
                .frame(width: 150, height: 150)
                .offset(x: -110, y: -300)
            
            Triangle()
                .stroke(Color.red, lineWidth: 4)
                .frame(width: 100, height: 100)
                .offset(x: -40, y: 350)
                .rotationEffect(.degrees(10), anchor: .center)
            
            Triangle()
                .stroke(Color.yellow, lineWidth: 4)
                .frame(width: 100, height: 100)
                .offset(x: 0, y: 230)
                .rotationEffect(.degrees(165), anchor: .center)

            Circle()
                .stroke(Color.blue, style: StrokeStyle(lineWidth: 4, dash: [8]))
                .frame(width: 100, height: 100)
                .offset(x: 160, y: 180)
            
            
            AnimatedImage(name: "pet.gif", isAnimating: $isLoading)
                .resizable()
                .scaledToFit()
                .frame(width: 600, height: 600)

        }
    }
}

#Preview {
    LoadingView()
}
