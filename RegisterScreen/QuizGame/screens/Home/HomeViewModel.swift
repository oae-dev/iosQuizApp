//
//  HomeViewModel.swift
//  RegisterScreen
//
//  Created by Sequoia on 12/09/25.
//

import Foundation
import SwiftUI

struct OpenRouterMessage: Codable {
    let role: String
    let content: String
}

struct OpenRouterRequest: Codable {
    let model: String
    let messages: [OpenRouterMessage]
    let max_tokens: Int?
}


@MainActor
class HomeViewModel: ObservableObject {
    private let apiKey = "sk-or-v1-3ea5278"
    @Published var quizzes: [QuizDetailInfo] = []
    @Published var errorMessage = ""
    @Published var openSheet:Bool = false
    @Published var loader: Bool = false 
    @Published var search:String = ""
    
    let colors: [Color] = [
        .red,  .blue, .indigo, .pink, .orange, .purple,  .yellow, .teal,  .orange
    ]
    @Published var defultQuizzes: [QuizDetailInfo] = [
        QuizDetailInfo(
            id: "1",
            title: "Basic Math",
            type: "math",
            questions: [
                QuizQuestion(
                    id: "1", question: "What is 2 + 2?",
                    options: ["3", "4", "5", "6"],
                    correctAnswer: "4"
                ),
                QuizQuestion(
                    id: "2", question: "What is 10 ÷ 2?",
                    options: ["2", "4", "5", "10"],
                    correctAnswer: "5"
                ),
                QuizQuestion(
                    id: "3", question: "What is 5 × 3?",
                    options: ["8", "10", "15", "20"],
                    correctAnswer: "15"
                )
            ],
            selected: false
        ),
        QuizDetailInfo(
            id: "2",
            title: "World History",
            type: "history",
            questions: [
                QuizQuestion(
                    id: "3", question: "Who was the first US president?",
                    options: ["George Washington", "Abraham Lincoln", "John Adams", "Thomas Jefferson"],
                    correctAnswer: "George Washington"
                ),
                QuizQuestion(
                    id: "2", question: "When did World War II start?",
                    options: ["1914", "1939", "1945", "1960"],
                    correctAnswer: "1939"
                ),
                QuizQuestion(
                    id: "3", question: "Who built the pyramids?",
                    options: ["Romans", "Greeks", "Egyptians", "Mayans"],
                    correctAnswer: "Egyptians"
                )
            ],
            selected: false
        ),
        QuizDetailInfo(
            id: "3",
            title: "Advanced Math",
            type: "math",
            questions: [
                QuizQuestion(
                    id: "3", question: "Solve for x: 2x + 3 = 7",
                    options: ["x = 1", "x = 2", "x = 3", "x = 4"],
                    correctAnswer: "x = 2"
                ),
                QuizQuestion(
                    id: "4", question: "What is ∫x² dx?",
                    options: ["x³/3 + C", "2x", "x²/2 + C", "ln(x)"],
                    correctAnswer: "x³/3 + C"
                ),
                QuizQuestion(
                    id: "2", question: "What is d/dx of sin(x)?",
                    options: ["cos(x)", "-cos(x)", "sin(x)", "-sin(x)"],
                    correctAnswer: "cos(x)"
                )
            ],
            selected: false
        ),
        QuizDetailInfo(
            id: "4",
            title: "Modern History",
            type: "history",
            questions: [
                QuizQuestion(
                    id: "34", question: "When did India gain independence?",
                    options: ["1947", "1950", "1939", "1965"],
                    correctAnswer: "1947"
                ),
                QuizQuestion(
                    id: "s34", question: "Who was Napoleon?",
                    options: ["French Emperor", "Italian Explorer", "German Chancellor", "Russian Tsar"],
                    correctAnswer: "French Emperor"
                ),
                QuizQuestion(
                    id: "34", question: "When did the Cold War end?",
                    options: ["1989", "1945", "1962", "2001"],
                    correctAnswer: "1989"
                )
            ],
            selected: false
        )
    ]
    @Published var mathQuizzes: [QuizDetailInfo] = []
    @Published var historyQuizzes: [QuizDetailInfo] = []
    @Published var biologyQuizzes: [QuizDetailInfo] = []
    
    func quizInSection(){
        mathQuizzes = quizzes.filter{$0.type == "math"}
        historyQuizzes = quizzes.filter{ $0.type == "history" }
        biologyQuizzes = quizzes.filter{ $0.type == "biology" }
    }
    
    
    
    func fetchAllQuizs() async {
        loader = true
            defer { loader = false }
        print("start")
            guard let url = URL(string: "https://openrouter.ai/api/v1/chat/completions") else { return }
            
            let requestBody = OpenRouterRequest(
                model: "deepseek/deepseek-chat-v3.1:free",
                messages: [
                    .init(role: "system", content: """
            You are a JSON generator. 
            Respond with **only** valid JSON: an array of quizz structure. 
            Do not include any text, markdown, backticks, or explanations. 
            It must match this Swift structure exactly:
            
            {
              "id": String,
              "title": String,
              "type": String,
              "questions": [
                {
                  "id": String,
                  "question": String,
                  "options": [String],
                  "correctAnswer": String
                }
              ],
              "selected": Bool
            }
            
            """),
                    .init(role: "user", content: "Generate 7 quizes with each type: math, histoy, biology")
                ], max_tokens: 4000
            )
            
            do {
                var request = URLRequest(url: url)
                request.httpMethod = "POST"
                request.addValue("application/json", forHTTPHeaderField: "Content-Type")
                request.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
                request.httpBody = try JSONEncoder().encode(requestBody)
                
                let (data, _) = try await URLSession.shared.data(for: request)

                if let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
                   let choices = json["choices"] as? [[String: Any]],
                   let message = choices.first?["message"] as? [String: Any],
                   let content = message["content"] as? String {
                    print("RAW MODEL CONTENT:\n\(content)\n")
                    
                    let cleaned = content
                        .replacingOccurrences(of: "```json", with: "")
                        .replacingOccurrences(of: "```", with: "")
                        .trimmingCharacters(in: .whitespacesAndNewlines)
                    loader = false
                    
                    if let jsonData = cleaned.data(using: .utf8) {
                        do {
                            let decoded = try JSONDecoder().decode([QuizDetailInfo].self, from: jsonData)
                            self.quizzes = decoded
                            quizInSection()
                            print("✅ Decoded quiz:", decoded)
                            print("end")
                        } catch {
                            print("❌ Decoding failed:", error)
                            errorMessage = "Decoding failed: \(error)"
                        }
                    }
                }
            } catch {
                errorMessage = "Error: \(error.localizedDescription)"
            }
        }
    }
