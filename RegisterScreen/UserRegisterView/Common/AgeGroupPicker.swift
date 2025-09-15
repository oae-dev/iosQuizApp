//
//  AgeGroupPicker.swift
//  RegisterScreen
//
//  Created by Sequoia on 06/09/25.
//

import SwiftUI

struct AgeGroupPicker: View {
    @Binding var value: String
    let pickerValues: [String]

    var body: some View {
            Picker("", selection: $value) {
                ForEach(pickerValues, id: \.self){value in
                    Text("\(value)")
                        .foregroundStyle(Color.white)
                        .font(.system(size: 30))
                        .tag("\(value)")
                }
            }.pickerStyle(.wheel)
    }
}

#Preview {
    AgeGroupPicker(
            value: .constant("Age Group 1-2"),
            pickerValues: ["Age Group 1-2", "Age Group 3-5", "Age Group 6-10"]
        )
}
