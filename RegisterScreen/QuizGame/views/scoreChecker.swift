//
//  scoreChecker.swift
//  RegisterScreen
//
//  Created by Sequoia on 10/09/25.
//

import SwiftUI

struct scoreChecker: View {
    let score: Int
    let totalQuestions: Int
    var body: some View {
        ZStack{
            Circle()
                .frame(maxWidth: .infinity)
                .foregroundStyle(.blue)
            
            Circle()
                .frame(maxWidth: .infinity)
                .padding()
                .foregroundStyle(.red)
            
            VStack(spacing: 10){
                Text("Your Score")
                Text("\(score) / \(totalQuestions)")
            }.foregroundStyle(.white)
                .font(.system(size: 30))
        }
    }
}

#Preview {
    scoreChecker(score: 4, totalQuestions: 6)
}
