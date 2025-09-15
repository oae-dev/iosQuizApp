//
//  PickerField.swift
//  RegisterScreen
//
//  Created by Sequoia on 06/09/25.
//

import SwiftUI

struct PickerField: View {
    var title: String
    @Binding var value: String
    var placeHolder:String
    var ontap: () -> ()
    var body: some View {
        VStack(alignment:.leading) {
            Text(title)
                .font(.system(size: 18, weight: .bold))
            HStack{
                Text(value.isEmpty ? placeHolder : value)
                    .foregroundStyle(value.isEmpty ? .gray : .primary)
                
                Spacer()
                
                Image(systemName: "chevron.down.circle")
                    .foregroundStyle(.black)
            }
            .padding()
            .background(RoundedRectangle(cornerRadius: 8).stroke(.black))
            .contentShape(Rectangle()).onTapGesture {
                ontap()
            }
            
        }
    }
}

#Preview {
    PickerField(title: "number", value: .constant(""), placeHolder: "1234554321", ontap:{
        print("opnePicker")
    } )
}
