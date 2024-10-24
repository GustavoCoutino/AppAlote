//
//  QuizView.swift
//  AppAlote
//
//  Created by Gustavo Coutiño on 23/10/24.
//
import SwiftUI

struct QuizView: View {
    @State private var currentQuestionIndex = 0
    @State private var selectedAnswer: Int? = nil
    @State private var quizCompleted = false
    @StateObject private var routeCalculator = RouteCalculator() // Initialize RouteCalculator
    
    private let squareSize = UIScreen.main.bounds.width / 2 - 40

    var body: some View {
        VStack {
            if quizCompleted {
                let finalRoute = routeCalculator.calculateRoute()
                VStack {
                    Text("Quiz Completado!")
                        .font(.largeTitle)
                        .padding()

                    Text("Tu Ruta:")
                        .font(.headline)
                        .padding(.top)

                    ForEach(finalRoute, id: \.self) { step in
                        Text(step)
                            .font(.title2)
                            .padding(.top, 5)
                    }
                }
            } else {
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
                                            routeCalculator.recordAnswer(color: color) // Record the selected color
                                            moveToNextQuestion()
                                        }
                                        .padding(1)
                                }
                            }
                        }
                    }
                }
                .padding(.horizontal, 20)
                
                Spacer()
            }
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
    
    private func moveToNextQuestion() {
        if currentQuestionIndex < QuizData.questions.count - 1 {
            currentQuestionIndex += 1
            selectedAnswer = nil
        } else {
            quizCompleted = true
        }
    }
}

#Preview {
    QuizView()
}
