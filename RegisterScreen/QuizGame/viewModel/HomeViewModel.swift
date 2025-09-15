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
}


@MainActor
class HomeViewModel: ObservableObject {
    private let apiKey = "sk-or-v1-3ea527e68"
    @Published var quizzes: [QuizDetailInfo] = []
    @Published var errorMessage = ""
    @Published var openSheet:Bool = false
    @Published var loader:Bool = false
   
    let colors: [Color] = [
        .red,  .blue, .indigo, .pink, .orange, .purple,  .yellow, .teal,  .orange
    ]
    @Published var search:String = ""

    func fetchQuiz() async {
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
                    .init(role: "user", content: "Generate 5 quizes about: \(search)")
                ]
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
                    
                    if let jsonData = cleaned.data(using: .utf8) {
                        do {
                            let decoded = try JSONDecoder().decode([QuizDetailInfo].self, from: jsonData)
                            self.quizzes = decoded
                            print("✅ Decoded quiz:", decoded)
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
