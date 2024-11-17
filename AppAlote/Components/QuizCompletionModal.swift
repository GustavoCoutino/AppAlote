//
//  QuizCompletionModal.swift
//  AppAlote
//
//  Created by Gustavo Coutiño on 15/11/24.
//

import SwiftUI

struct QuizCompletionModal: View {
    @Binding var isPresented : Bool
    var body: some View {
        ZStack {
            Color.black.opacity(0.5).edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 20){
                Text("Analizando resultados del quiz").font(.title).bold()
                ProgressView().progressViewStyle(CircularProgressViewStyle()).scaleEffect(2)
            }.padding(40).background(Color.white).cornerRadius(20).shadow(radius: 10)
            
        }.onAppear {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
        .onDisappear {
            UIApplication.shared.sendAction(#selector(UIResponder.becomeFirstResponder), to: nil, from: nil, for: nil)
        }
    }
}

#Preview {
    QuizCompletionModal(isPresented: .constant(true))
}
