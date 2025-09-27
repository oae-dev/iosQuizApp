//
//  SplashScreen.swift
//  RegisterScreen
//
//  Created by Sequoia on 08/09/25.
//

import SwiftUI

enum QuizScreens: Hashable, Equatable {
    case login
    case home(userData:UsersData)
    case gameScreen([QuizScreenConfig], userName: String)
    case result(score: Int, totalQuestions: Int, userName: String)
}

struct SplashScreen: View {
    @State var path: NavigationPath = NavigationPath()
    var body: some View {
        NavigationStack(path: $path) {
            VStack(spacing: 60){
                Text("Welcome")
                    .font(.system(size: 70, weight: .bold))
                Text("The QuizApp")
                    .font(.system(size: 30))
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    path.append(QuizScreens.login)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                LinearGradient(colors: [.green, .red, .yellow, .accentColor], startPoint: .topLeading, endPoint: .bottomTrailing)
            )
            .navigationDestination(for: QuizScreens.self) { route in
                switch route {
                case .login :
                    loginOrSignUpScreen(path: $path)
                case .home(let userData):
                    HomeTabBar(path: $path,userData: userData)
                case .gameScreen(let quizScreenConfig, let userName):
                    GameScreen(path: $path, allQuizConfigs: quizScreenConfig, userName: userName)
                case .result(let score, let totalQuestions, let userName):
                    ResultScreen(score: score, totalQuestions: totalQuestions, userName: userName, path: $path)
                }
            }
            
            
        }
    }}

#Preview {
    SplashScreen()
}
