//
//  loginOrSignUpScreen.swift
//  RegisterScreen
//
//  Created by Sequoia on 19/09/25.
//

import SwiftUI
import _PhotosUI_SwiftUI

struct loginOrSignUpScreen: View {
    @Binding var path: NavigationPath
    @State var email:String = ""
    @State var isValid: Bool? = true
    @State var isSignUpPage:Bool = false
    @ObservedObject var vm = loginViewModel()
    let users = DbTable.shared.FetchUsers()
    var body: some View {
        
        
        ScrollView {
            
            VStack {
                if isSignUpPage {
                    signUpSection
                } else {
                    loginSection
                }
            }
            .ignoresSafeArea()
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.indigo))
            .padding()
            
        }
        .navigationTitle("")
        .navigationBarBackButtonHidden()
        .sheet(isPresented: $vm.showImagePicker) {
            PhotosPicker("", selection: $vm.selectedItem)
                .photosPickerStyle(.inline)
        }
        .onChange(of: vm.selectedItem) {
            Task {
                if let data = try? await vm.selectedItem?.loadTransferable(type: Data.self),
                   let uiImage = UIImage(data: data) {
                    await MainActor.run {
                        vm.profileImage = uiImage
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            Image("background")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
        )
        
        
    }
    
    var loginSection: some View{
        VStack(alignment: .leading, spacing: 20){
            Text("Welcome To Login")
                .font(.system(size: 30, weight: .bold))
                .foregroundStyle(.white)
            TitileTextField(title: " Email", input: $email, unValid: $isValid)
            
            TitileTextField(title: "Password", input: $email, keyBoardType: .numberPad, unValid: $isValid)
            
            Text("Forget Password")
                .foregroundStyle(Color.white)
            
            Button {
//                path.append(QuizScreens.home(userData: userData))
                for data in users {
                    print(data)
                }
                print("login")
            } label: {
                Text("LogIn")
                    .font(.system(size: 25, weight: .semibold))
                    .foregroundStyle(.white)
                    .padding(.horizontal, 80)
                    .padding(.vertical, 15)
                    .background(
                        Capsule()
                            .fill(.blue)
                    )
            }
            .frame(maxWidth: .infinity)
            Text("I haven't a account")
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity, alignment: .center)
                .onTapGesture {
                    isSignUpPage.toggle()
                }
        }
    }
    
    var signUpSection: some View{
        VStack(spacing: 20){
            Text("SignUp")
                .font(.system(size: 30, weight: .bold))
                .foregroundStyle(.white)
            if let profileImage = vm.profileImage {
                Image(uiImage: profileImage)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())
            } else {
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.gray)
                    .onTapGesture {
                        vm.showImagePicker.toggle()
                    }
            }
            TitileTextField(title: "Username", input: $vm.userName, unValid: $isValid)
            
            TitileTextField(title: "Email", input: $vm.email, keyBoardType: .numberPad, unValid: $isValid)
            
            TitileTextField(title: "DOB", input: $vm.dob, unValid: $isValid)
            
            TitileTextField(title: "Phone", input: $vm.phoneNumber, unValid: $isValid)
            
            TitileTextField(title: "Password", input: $vm.password, keyBoardType: .numberPad, unValid: $isValid)
            
            Button {
                DbTable.shared.AddUser(email:vm.email, userName:vm.userName, password:vm.password, DOB:vm.dob, phone: vm.phoneNumber)
//                path.append(QuizScreens.home(userData: userData))
                print("SignUp")
            } label: {
                Text("SignUp")
                    .font(.system(size: 25, weight: .semibold))
                    .foregroundStyle(.white)
                    .padding(.horizontal, 80)
                    .padding(.vertical, 15)
                    .background(
                        Capsule()
                            .fill(.blue)
                    )
            }
            .frame(maxWidth: .infinity)
            
            Text("Already, have a account")
                .foregroundStyle(.white)
                .onTapGesture {
                    isSignUpPage.toggle()
                }
        }
    }
}

#Preview {
    loginOrSignUpScreen(path: .constant(NavigationPath()))
}
