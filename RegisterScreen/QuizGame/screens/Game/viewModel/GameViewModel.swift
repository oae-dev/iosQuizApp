//
//  GameViewModel.swift
//  RegisterScreen
//
//  Created by Dev on 30/09/25.
//

import Foundation
import AVFoundation

class GameViewModel: ObservableObject {
    @Published var currentQuestion:Int = 0
    @Published var currentScreen: Int = 0
    @Published var selectedAnswer: String = ""
    @Published var score: Int = 0
    @Published var totalQuestions:Int = 0
    @Published var showAnswer: Bool = false
    
    let synthesizer = AVSpeechSynthesizer()
    
    func textToSpeach(_ text: String) {
        guard !text.isEmpty else { return }
        
        if synthesizer.isSpeaking {
            synthesizer.stopSpeaking(at: .immediate)
        }
        
        let Utterance = AVSpeechUtterance(string: text)
        Utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        synthesizer.speak(Utterance)
    }
}
