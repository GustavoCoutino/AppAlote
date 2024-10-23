//
//  ProgressBar.swift
//  AppAlote
//
//  Created by Gustavo Coutiño on 23/10/24.
//

import Foundation
import SwiftUI

struct ProgressBar: View {
    var progress: CGFloat

    var body: some View {
        ZStack(alignment: .leading) {
            Capsule()
                .frame(width: UIScreen.main.bounds.width - 40, height: 20)
                .foregroundColor(Color.gray.opacity(0.3)).overlay(
                    Capsule()
                        .stroke(Color.black, lineWidth: 2)
                )
            Capsule()
                .frame(width: (UIScreen.main.bounds.width - 40) * progress, height: 20)
                .foregroundColor(Color(red: 210/255, green: 222/255, blue: 73/255))
                .animation(.easeInOut(duration: 0.5), value: progress)
            
        }
        .padding(.horizontal, 20)
    }
}

#Preview {
    ProgressBar(progress: 0.3)
}
