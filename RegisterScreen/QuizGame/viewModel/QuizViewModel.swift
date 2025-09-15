//
//  QuizViewModel.swift
//  RegisterScreen
//
//  Created by Sequoia on 09/09/25.
//

import Foundation

class QuizScreensConfigurator {
    private let quiz: QuizDetailInfo
    init(quiz: QuizDetailInfo) {
        self.quiz = quiz
    }
    
    func quizConfig() -> [QuizScreenConfig] {
        var screen : [QuizScreenConfig] = []
        if quiz.type == "math" {
            let config = QuizScreenConfig(id: quiz.id,
                                          title: quiz.title,
                                          questions: quiz.questions,
                                          hasTimer: true,
                                          showHints: true,
                                          background: "https://slidechef.net/wp-content/uploads/2023/10/Math-Background-768x432.jpg")
            screen.append(config)
        } else if quiz.type == "history" {
            let config = QuizScreenConfig(id: quiz.id,
                                          title: quiz.title,
                                          questions: quiz.questions,
                                          hasTimer: true,
                                          background: "https://media.istockphoto.com/id/533575448/vector/paper-background-with-copy-space-and-pirate-map.jpg?s=612x612&w=0&k=20&c=uydCsgfo3CofHZFO_z1KKK_5CYlPjxv94oeJFNSpK34=")
            screen.append(config)
        } else {
            let config = QuizScreenConfig(id: quiz.id,
                                          title: quiz.title,
                                          questions: quiz.questions,
                                          hasTimer: true,
                                          showHints: false, background: "https://slidechef.net/wp-content/uploads/2023/10/Math-Background-768x432.jpg")
            screen.append(config)
        }
        return screen
    }
}
