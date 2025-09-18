//
//  EditTableTextField.swift
//  RegisterScreen
//
//  Created by Sequoia on 18/09/25.
//

import SwiftUI

struct EditTableTextField: View {
    let title:String
    @Binding var isEdit:Bool
    @Binding var field: String
    
    var body: some View {
        VStack{
            HStack{
                Text("\(title) : ")
                    .font(.body)
                    
                
                if isEdit {
                    TextField("", text: $field)
                        .overlay(alignment: .trailing) {
                            Image(systemName: "checkmark")
                                .resizable()
                                .foregroundStyle(Color.green)
                                .frame(width: 20, height: 14)
                                .padding(.trailing)
                                .onTapGesture {
                                    isEdit = false
                                }
                        }
                   
                } else {
                    Text(field)
                        .foregroundStyle(Color.black.opacity(0.7))
                    
                    
                    Spacer()
                    Image(systemName: "pencil")
                        .padding(.trailing)
                        .onTapGesture {
                            isEdit = true
                        }
                }
            }
            
            Divider()
                .frame(height: 1)
                .background(Color.gray)
          }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    EditTableTextField(title: "email", isEdit: .constant(true), field: .constant("ad2@gmail.com"))
}
