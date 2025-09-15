//
//  BoxSelector.swift
//  RegisterScreen
//
//  Created by Sequoia on 10/09/25.
//

import SwiftUI

struct BoxSelector: View {
    var selected: Bool
    var ontap: () -> ()
    var quiztitle: String
    var wrongAnswer: Bool?
    var deviceWidth = UIScreen.main.bounds.width
    var bg:Color
    
    var title: String {
        makeLogoName(title: quiztitle)
    }
    
    var body: some View {
        VStack (spacing:15) {
            Image(systemName: "inset.filled.circle")
                .resizable()
                .frame(width: 25, height: 25)
                .foregroundStyle(wrongAnswer ?? false ? .red :selected ? .green : Color.clear)
                .padding(.trailing, 20)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Circle()
                .fill(bg)
                .padding(.horizontal, 30)
                .overlay {
                    Text(title)
                        .font(.system(size: 30, weight: .heavy))
                        .foregroundStyle(Color.white)
                }
            
            Text("\(quiztitle)")
                .font(.system(size: 20, weight: .bold))
                .multilineTextAlignment(.center)
            
            Spacer()
        }
        .frame(width: deviceWidth / 2.7 , height: 200)
        
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(LinearGradient(colors: [bg.opacity(0.4),bg.opacity(0.6) ,bg.opacity(0.8)], startPoint: .topLeading, endPoint: .bottomTrailing))
                .shadow(color: .black.opacity(0.3), radius: 10, x: 6, y: 6)
                .shadow(color: .white.opacity(0.4), radius: 8, x: -4, y: -4)
        )
        .scaleEffect(selected ? 1.05 : 1.0) // Pop out effect
        .animation(.spring(response: 0.3, dampingFraction: 0.6), value: selected)
        //        .overlay(content: {
        //            wrongAnswer ?? false ? RoundedRectangle(cornerRadius: 10)
        //                .stroke(Color.red, lineWidth: 2) :
        //            selected ?
        //            RoundedRectangle(cornerRadius: 10)
        //                .stroke(Color.green, lineWidth: 2)
        //            : RoundedRectangle(cornerRadius: 10)
        //                .stroke(Color.blue, lineWidth: 2)
        //
        //        })
        .onTapGesture {
            ontap()
        }
    }
    
    func makeLogoName(title:String) -> String {
        let parts = title.split(separator: " ")
        let laters = parts.compactMap { $0.first }
        let logo = laters.map { String($0)}.joined()
        return logo
    }
}


#Preview {
    BoxSelector(selected: true, ontap:{print("")}, quiztitle: "Basicccg Math", bg: .red)
}


