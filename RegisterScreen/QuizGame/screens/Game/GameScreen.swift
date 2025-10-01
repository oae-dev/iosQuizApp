//
//  GameScreen.swift
//  RegisterScreen
//
//  Created by Sequoia on 09/09/25.
//

import SwiftUI

struct GameScreen: View {
    @Binding var path: NavigationPath
    @StateObject var vm = GameViewModel()
    var allQuizConfigs: [QuizScreenConfig]
    let userName: String
    
    var body: some View {
        VStack{
            Text(allQuizConfigs[vm.currentScreen].title)
                .font(.system(size: 40, weight: .bold))
            
            Text("Question - \(vm.currentQuestion + 1) / \(allQuizConfigs[vm.currentScreen].questions.count)")
                .font(.system(size: 30, weight: .bold))
            
            Spacer()
            
            Text(allQuizConfigs[vm.currentScreen].questions[vm.currentQuestion].question)
                .font(.system(size: 40, weight: .bold))
            
            let options = allQuizConfigs[vm.currentScreen].questions[vm.currentQuestion].options
            let correctAnswer = allQuizConfigs[vm.currentScreen].questions[vm.currentQuestion].correctAnswer
            ForEach(0..<options.count) { index in
                let option = options[index]
                let iswrong = vm.showAnswer && option == vm.selectedAnswer && option != correctAnswer

                
                Selector(selected: options[index] == vm.selectedAnswer, ontap: {
                    vm.selectedAnswer = options[index]
                }, quiztitle: allQuizConfigs[vm.currentScreen].questions[vm.currentQuestion].options[index], wrongAnswer: iswrong)
            }
            
            Spacer()
            
            Button {
                vm.showAnswer = true
                
                if vm.selectedAnswer == correctAnswer {
                    vm.score += 1
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                    vm.totalQuestions += 1
                    vm.showAnswer = false
                    vm.selectedAnswer = ""
                    if vm.currentQuestion < allQuizConfigs[vm.currentScreen].questions.count - 1{
                        withAnimation (.snappy){
                            vm.currentQuestion += 1
                        }
                        
                        vm.textToSpeach(allQuizConfigs[vm.currentScreen].questions[vm.currentQuestion].question)
                        
                    }
                    else if vm.currentScreen == allQuizConfigs.count - 1{
                        path.append(QuizScreens.result(score: vm.score, totalQuestions: vm.totalQuestions, userName: userName))
                    }
                    else {
                        withAnimation(.bouncy){
                            vm.currentScreen += 1
                        }
                        vm.currentQuestion = 0
                        vm.showAnswer = false
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
            AsyncImage(url: URL(string: allQuizConfigs[vm.currentScreen].background)){ phase in
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
        .onAppear {
            vm.textToSpeach(allQuizConfigs[vm.currentScreen].questions[vm.currentQuestion].question)
        }
    }
}

//#Preview {
//    GameScreen(allQuizConfigs: [QuizScreenConfig(id: "1", title: "Name is", questions: ["a question","b Question"], hasTimer: false, showHints: false, background: "https://slidechef.net/wp-content/uploads/2023/10/Math-Background-768x432.jpg")])
//}
