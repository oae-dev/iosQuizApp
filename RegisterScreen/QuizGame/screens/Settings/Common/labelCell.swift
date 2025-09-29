//
//  labelCell.swift
//  RegisterScreen
//
//  Created by Dev on 29/09/25.
//

import SwiftUI

struct labelCell: View {
    let logo: String
    let title: String
    var body: some View {
        HStack {
            Image(systemName: logo)
                .resizable()
                .frame(width: 35, height: 35)
            Text(title)
                .font(.system(size: 20))
                .padding(.leading)
            Spacer()
            Image(systemName: "arrow.right")
                .resizable()
                .frame(width: 15, height: 15)
        }
        .foregroundStyle(Color.primary)
    }
}

#Preview {
    labelCell(logo: "person.crop.circle.fill", title: "profile")
}
