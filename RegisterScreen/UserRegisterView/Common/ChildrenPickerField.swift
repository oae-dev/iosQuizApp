//
//  ChildrenPickerField.swift
//  RegisterScreen
//
//  Created by Sequoia on 06/09/25.
//

import SwiftUI

struct ChildrenPickerField: View {
    var title: String
    @Binding var value: Int?
    var placeHolder:String
    var ontap: () -> ()
    var body: some View {
        VStack(alignment:.leading) {
            Text(title)
                .font(.system(size: 18, weight: .bold))
            HStack{
                Text(value != nil ? "\(value ?? 0)" : placeHolder)
                                    .foregroundStyle(value == nil ? .gray : .primary)
                
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
    ChildrenPickerField(title: "number", value: .constant(0), placeHolder: "1234554321", ontap:{
        print("opnePicker")
    } )
}
