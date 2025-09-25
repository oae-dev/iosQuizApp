//
//  SearchBar.swift
//  RegisterScreen
//
//  Created by Sequoia on 12/09/25.
//

import SwiftUI

struct SearchBar: View {
    @Binding var value: String
    var onSearchTap: () -> ()
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 30)
                .stroke(lineWidth: 2)
                .padding(3)
            HStack {
                TextField("Search New Game", text: $value)
                    .font(.system(size: 20, weight: .medium))
                    .padding(.horizontal,value.isEmpty ? 50 : 10)
                    .padding(.vertical)
            }
            
            Image(systemName: "magnifyingglass.circle")
                .resizable()
                .frame(width: 30, height: 30)
                .padding(.horizontal, 10)
                .frame(maxWidth: .infinity, alignment: value.isEmpty ? .leading : .trailing)
                .animation(.easeInOut(duration: 0.2), value: value.isEmpty)
                .onTapGesture {
                    hideKeyboard()
                    if !value.isEmpty{
                        onSearchTap()
                    }
                }
        }
        .foregroundStyle(Color.black)
    }
}

#Preview {
    SearchBar(value: .constant(""), onSearchTap: {print("df")})
        .padding()
        .background(Color.accentColor)
}

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(
            #selector(UIResponder.resignFirstResponder),
            to: nil,
            from: nil,
            for: nil
        )
    }
}
