//
//  PickerHeader.swift
//  RegisterScreen
//
//  Created by Sequoia on 06/09/25.
//

import SwiftUI

struct PickerHeader: View {
    var body: some View {
        HStack {
            Image(systemName: "oar.2.crossed")
                .resizable()
                .frame(width: 24,height: 24)
                .foregroundStyle(Color.white)
            Spacer()
            
            Text("Procced")
                .padding()
                .foregroundStyle(Color.white)
                .overlay {
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.accentColor ,lineWidth: 2)
                    
                }
        }
        
    }
}

#Preview {
    PickerHeader()
}
