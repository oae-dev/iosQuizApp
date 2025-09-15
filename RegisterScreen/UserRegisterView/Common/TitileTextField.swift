//
//  TitileTextField.swift
//  ios26
//
//  Created by Dev on 06/09/25.
//

import SwiftUI

struct TitileTextField: View {
    var title:String
    @Binding var input:String
    var keyBoardType:UIKeyboardType? = .default
    var secure:Bool? = false
    @Binding var unValid:Bool?
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.system(size: 18, weight: .bold))
                .foregroundStyle(unValid ?? false ? .black : .red)
            if secure ?? false {
                SecureField("", text: $input)
                    .keyboardType(keyBoardType ?? .default)
            } else {
                TextField("", text: $input)
                    .keyboardType(keyBoardType ?? .default)
            }
            
            Divider()
                .frame(height: 1)
                .background(unValid ?? false ? .black : .red)
        }
//        .onChange(of: input) { oldValue, newValue in
//            unValid = true
//        }
    }
}

#Preview {
    TitileTextField(title:"Email", input: .constant("a"), unValid: .constant(false))
}
