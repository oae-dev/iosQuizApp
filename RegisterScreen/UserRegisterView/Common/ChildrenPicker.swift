//
//  ChildrenPicker.swift
//  RegisterScreen
//
//  Created by Sequoia on 06/09/25.
//

import SwiftUI

struct ChildrenPicker: View {
    @Binding var value: Int?
    @State var PickerValues: [Int]
    
    var body: some View {
        Picker("", selection: $value) {
            ForEach(PickerValues, id: \.self){ value in
                Text("\(value)")
                    .foregroundStyle(Color.white)
                    .font(.system(size: 30))
                    .tag(value)
            }
        }
        .pickerStyle(.wheel)
    }
}

#Preview {
    ChildrenPicker(value: .constant(1), PickerValues: Array(1..<10))
}
