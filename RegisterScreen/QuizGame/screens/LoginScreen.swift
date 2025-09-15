//
//  LoginScreen.swift
//  RegisterScreen
//
//  Created by Sequoia on 08/09/25.
//

import SwiftUI

struct UserData: Hashable{
    var name: String
    var age: String
}

struct LoginScreen: View {
    @Binding var path: NavigationPath
    @State var userData: UserData = UserData(name: "", age: "")
    @State var nameValid: Bool? = true
    @State var ageValid: Bool? = true
    
    var body: some View {
        VStack {
            Image("bg")
                .resizable()
            
            VStack(spacing: 25) {
                Text("Welcome To Login")
                    .font(.largeTitle)
                
                TitileTextField(title: "Enter your Name", input: $userData.name, unValid: $nameValid)
                
                TitileTextField(title: "Your Age", input: $userData.age, keyBoardType: .numberPad, unValid: $ageValid)
                
                Button {
                    
                    let isNameValid = userData.name.count > 3
                    let isAgeValid = userData.age.count > 0
                    
                    nameValid = isNameValid
                    ageValid = isAgeValid
                    
                    if isAgeValid && isNameValid {
                        path.append(QuizScreens.home(userData: userData))
                    }
                        
                } label: {
                    Text("Log In")
                        .font(.system(size: 25, weight: .semibold))
                        .foregroundStyle(.white)
                        .padding(.horizontal, 100)
                        .padding(.vertical, 15)
                        .background(
                            Capsule()
                                .fill(.blue)
                        )
                }
                .frame(maxWidth: .infinity)
                .padding(.bottom)
                
            }
            .padding(35)
            .background(
                RoundedRectangle(cornerRadius: 25)
                    .fill(Color.accentColor.opacity(0.4))
                
            )
           
        }
        .onChange(of: userData, { oldValue, newValue in
            nameValid = true
            ageValid = true
        })
        .onTapGesture {
            hideKeyboard()
        }
        .frame(maxHeight: .infinity)
        .ignoresSafeArea()
        .navigationTitle("")
        .navigationBarBackButtonHidden()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemGray6))
    }

}

#Preview {
    LoginScreen(
        path: .constant(NavigationPath())
    )
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
