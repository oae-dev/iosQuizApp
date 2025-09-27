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
    @Binding var error:String?
    var isReadOnly: Bool? = false
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack{
                Text(title)
                    .font(.system(size: 18, weight: .bold))
                    .foregroundStyle((error == nil) ? .black : .red)
                
                Spacer()
                
                if let error = error, !error.isEmpty {
                    Text(error)
                        .font(.system(size: 14))
                        .foregroundStyle(.red)
                }
            }
            if  isReadOnly ?? false {
                HStack {
                    Text(input)
                        .padding(.top, input.isEmpty ? 16 : 3)
                    Spacer()
                }
                .contentShape(Rectangle())
            } else if secure ?? false {
                SecureField("", text: $input)
                    .keyboardType(keyBoardType ?? .default)
            } else {
                TextField("", text: $input)
                    .keyboardType(keyBoardType ?? .default)
            }
            
            Divider()
                .frame(height: 1)
                .background((error == nil) ?  .black : .red)
        }
        .onChange(of: input) {
            error = nil
        }
    }
}

#Preview {
    TitileTextField(title:"Email", input: .constant("a"), error: .constant("errpr"))
}
