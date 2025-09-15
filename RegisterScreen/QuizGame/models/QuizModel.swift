//
//  QuizModel.swift
//  RegisterScreen
//
//  Created by Sequoia on 09/09/25.
//

import Foundation

struct QuizDetailInfo: Identifiable, Hashable, Codable {
    let id: String
    let title: String
    let type: String
    let questions: [QuizQuestion]
    var selected: Bool
    
}

struct QuizQuestion: Identifiable, Hashable, Codable {
    let id: String
    let question: String
    let options: [String]
    let correctAnswer: String
}

struct QuizScreenConfig: Hashable {
    var id: String
    var title: String
    var questions: [QuizQuestion]
    var hasTimer: Bool
    var showHints: Bool?
    var background: String
}
