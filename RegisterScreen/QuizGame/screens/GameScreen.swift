//
//  GameScreen.swift
//  RegisterScreen
//
//  Created by Sequoia on 09/09/25.
//

import SwiftUI

struct GameScreen: View {
    @Binding var path: NavigationPath
    
    var allQuizConfigs: [QuizScreenConfig]
    @State var currentQuestion:Int = 0
    @State var currentScreen: Int = 0
    @State var selectedAnswer: String = ""
    @State var score: Int = 0
    @State var totalQuestions:Int = 0
    let userName: String
    
    @State private var showAnswer: Bool = false
    
    var body: some View {
        VStack{
            Text(allQuizConfigs[currentScreen].title)
                .font(.system(size: 40, weight: .bold))
            
            Text("Question - \(currentQuestion + 1) / \(allQuizConfigs[currentScreen].questions.count)")
                .font(.system(size: 30, weight: .bold))
            
            Spacer()
            
            Text(allQuizConfigs[currentScreen].questions[currentQuestion].question)
                .font(.system(size: 40, weight: .bold))
            
            let options = allQuizConfigs[currentScreen].questions[currentQuestion].options
            let correctAnswer = allQuizConfigs[currentScreen].questions[currentQuestion].correctAnswer
            ForEach(0..<options.count) { index in
                let option = options[index]
                let iswrong = showAnswer && option == selectedAnswer && option != correctAnswer

                
                Selector(selected: options[index] == selectedAnswer, ontap: {
                    selectedAnswer = options[index]
                }, quiztitle: allQuizConfigs[currentScreen].questions[currentQuestion].options[index], wrongAnswer: iswrong)
            }
            
            Spacer()
            
            Button {
                showAnswer = true
                
                if selectedAnswer == correctAnswer {
                    score += 1
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                    totalQuestions += 1
                    showAnswer = false
                    selectedAnswer = ""
                    if currentQuestion < allQuizConfigs[currentScreen].questions.count - 1{
                        withAnimation (.snappy){
                            currentQuestion += 1
                        }
                        
                    }
                    else if currentScreen == allQuizConfigs.count - 1{
                        path.append(QuizScreens.result(score: score, totalQuestions: totalQuestions, userName: userName))
                    }
                    else {
                        withAnimation(.bouncy){
                            currentScreen += 1
                        }
                        currentQuestion = 0
                        showAnswer = false
                        print("Next Screen")
                    }
                }
                
                
            } label: {
                Text("play")
                    .font(.system(size: 25, weight: .semibold))
                    .foregroundStyle(.white)
                    .padding(.horizontal, 100)
                    .padding(.vertical, 15)
                    .background(
                        Capsule()
                            .fill(.blue)
                    )
            }
            .frame(maxWidth: .infinity)
            .padding(.bottom)
             
        }
        .padding(.horizontal)
        .navigationTitle("")
        .navigationBarBackButtonHidden()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background {
            AsyncImage(url: URL(string: allQuizConfigs[currentScreen].background)){ phase in
                switch phase {
                case .empty:
                    ProgressView()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                        .ignoresSafeArea()
                case .failure(_):
                    Color.gray.ignoresSafeArea()
                @unknown default:
                    Color.gray.ignoresSafeArea()
                }
            }
            
        }
    }
}

//#Preview {
//    GameScreen(allQuizConfigs: [QuizScreenConfig(id: "1", title: "Name is", questions: ["a question","b Question"], hasTimer: false, showHints: false, background: "https://slidechef.net/wp-content/uploads/2023/10/Math-Background-768x432.jpg")])
//}
