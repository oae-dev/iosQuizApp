//
//  Selector.swift
//  RegisterScreen
//
//  Created by Sequoia on 09/09/25.
//

import SwiftUI

struct Selector: View {
    var selected: Bool
    var ontap: () -> ()
    var optionTitle: String
    var wrongAnswer: Bool?
    var correctAnswer: Bool
    
    var body: some View {
        HStack{
            Image(systemName: "inset.filled.circle")
                .resizable()
                .frame(width: 25, height: 25)
                .foregroundStyle(wrongAnswer ?? false ? .red :selected ? .green : Color.clear)
                .padding(.trailing, 20)
            
            Text("\(optionTitle)")
                .font(.system(size: 20, weight: .bold))
                
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(
            Capsule()
                .fill(.blue.opacity(0.3))
        )
        .overlay(content: {
            wrongAnswer ?? false ? Capsule()
                .stroke(Color.red, lineWidth: 2) :
            selected ?
            Capsule()
                .stroke(Color.green, lineWidth: 2)
            : Capsule()
                .stroke(Color.blue, lineWidth: 2)
            if correctAnswer {
                Capsule()
                    .stroke(Color.green, lineWidth: 2)
            }

        })
        .onTapGesture {
            ontap()
        }
    }
}

#Preview {
    Selector(selected: true, ontap:{print("")}, optionTitle: "math", correctAnswer: true)
}
