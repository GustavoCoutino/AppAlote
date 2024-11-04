//
//  QuizView.swift
//  AppAlote
//
//  Created by Gustavo Coutiño on 23/10/24.
//
import SwiftUI

struct QuizView: View {
    @EnvironmentObject var userManager: UserManager
    @State private var currentQuestionIndex = 0
    @State private var selectedAnswer: Int? = nil
    @State private var navigateToHome = false
    @StateObject private var routeCalculator : RouteCalculator
    init(userManager: UserManager) {
        _routeCalculator = StateObject(wrappedValue: RouteCalculator(userManager: userManager))
    }
    private let squareSize = UIScreen.main.bounds.width / 2 - 40

    var body: some View {
            VStack {
                let question = QuizData.questions[currentQuestionIndex]
                
                ProgressBar(progress: CGFloat(currentQuestionIndex + 1) / CGFloat(QuizData.questions.count))
                    .padding(.top, 20)
                
                Spacer()
                QuestionTitle(title: question.titulo)
                
                Spacer()
                VStack(spacing: 20) {
                    ForEach(0..<question.respuestas.count / 2, id: \.self) { row in
                        HStack(spacing: 10) {
                            ForEach(0..<2) { column in
                                let index = row * 2 + column
                                if index < question.respuestas.count {
                                    let color = getColor(for: index)
                                    Text(question.respuestas[index])
                                        .frame(width: squareSize, height: squareSize)
                                        .padding()
                                        .background(color)
                                        .cornerRadius(10)
                                        .foregroundColor(.white)
                                        .onTapGesture {
                                            selectedAnswer = index
                                            routeCalculator.recordAnswer(color: color) 
                                            Task {
                                                                                        await moveToNextQuestion()
                                                                        }
                                        }
                                        .padding(1)
                                }
                            }
                        }
                    }
                }
                .padding(.horizontal, 20).id(currentQuestionIndex)
                .animation(.easeInOut(duration: 0.5), value: currentQuestionIndex)
                
                Spacer()
            }
            .padding()
    }

    private func getColor(for index: Int) -> Color {
        let colors: [Color] = [
            Color(red: 173/255, green: 216/255, blue: 230/255), // Pequeños
            Color.green, // Pertenezco
            Color.blue, // Comunico
            Color(red: 0/255, green: 0/255, blue: 139/255), // Comprendo
            Color.orange, // Expreso
            Color.red // Soy
        ]
        return colors[index % colors.count]
    }
    
    private func moveToNextQuestion() async {
        if currentQuestionIndex < QuizData.questions.count - 1 {
            withAnimation(.easeInOut(duration: 0.5)) {
                currentQuestionIndex += 1
                selectedAnswer = nil
            }
        } else {
            await routeCalculator.submitQuizResults()
            userManager.setQuizCompleted()
        }
    }
}

#Preview {
    let userManager = UserManager()
    return QuizView(userManager: userManager).environmentObject(userManager)
}
