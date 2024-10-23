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
    
    private let squareSize = UIScreen.main.bounds.width / 2 - 40 // Adjust size for padding

    var body: some View {
        VStack {
            if quizCompleted {
                Text("Quiz Completed!")
                    .font(.largeTitle)
                    .padding()
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
                                    Text(question.respuestas[index])
                                        .frame(width: squareSize, height: squareSize)
                                        .padding()
                                        .background(getColor(for: index))
                                        .cornerRadius(10)
                                        .foregroundColor(.white)
                                        .onTapGesture {
                                            selectedAnswer = index
                                            moveToNextQuestion()
                                        }
                                        .overlay(
                                            selectedAnswer == index ? RoundedRectangle(cornerRadius: 10).stroke(Color.black, lineWidth: 2) : nil
                                        )
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
            Color(red: 173/255, green: 216/255, blue: 230/255),
            Color.green,
            Color.blue,
            Color(red: 0/255, green: 0/255, blue: 139/255),
            Color.orange,
            Color.red
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
