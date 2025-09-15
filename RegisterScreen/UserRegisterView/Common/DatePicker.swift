//
//  DatePicker.swift
//  RegisterScreen
//
//  Created by Sequoia on 06/09/25.
//

import SwiftUI

struct MyDatePicker: View {
    @Binding var value: String
    @State private var PickerValues = Date()
    
    private let formatter: DateFormatter = {
           let f = DateFormatter()
           f.dateStyle = .medium
           f.timeStyle = .none
           return f
       }()
    var body: some View {
        DatePicker("", selection: $PickerValues,
               displayedComponents: .date)
        .datePickerStyle(.wheel)
        .colorInvert()
        .labelsHidden()
        .colorMultiply(.white)
        .onChange(of: PickerValues) {
               value = formatter.string(from: PickerValues)
           }
        .frame(height: 212, alignment: .center)
        
    }
}

#Preview {
    MyDatePicker(value: .constant("1"))
}
