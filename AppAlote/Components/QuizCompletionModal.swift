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
            LoadingView()
            
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
