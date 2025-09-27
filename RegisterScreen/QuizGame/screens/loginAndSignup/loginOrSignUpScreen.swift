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
    @State var isSignUpPage:Bool = false
    @ObservedObject var vm = loginViewModel()
    
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
        .sheet(isPresented: $vm.showDobPicker) {
            DatePicker("", selection: $vm.date, displayedComponents: .date)
                .pickerStyle(.wheel)
                .labelsHidden()
        }
        .onChange(of: vm.date, {
            vm.dob = vm.formater(date: vm.date)
        })
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
            TitileTextField(title: " Email", input: $vm.email, error: vm.errorBinding(for: "loginEmail"))
            
            TitileTextField(title: "Password", input: $vm.password, keyBoardType: .numberPad, error: vm.errorBinding(for: "loginPassword"))
            
            Text("Forget Password")
                .foregroundStyle(Color.white)
            
            Button {
                vm.LoginValidEnterData()
                
                if vm.error == nil {
                    print("valid")
                    path.append(QuizScreens.home(userData: vm.validUserData(email: vm.email) ?? UsersData(id: 1, email: "", userName: "", password: "", DOB: "", Phone: "x")))
                } else {
                    print("unvalid")
                }

                for data in vm.users {
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
            TitileTextField(title: "Username", input: $vm.userName,  error: vm.errorBinding(for: "userName"))
            
            TitileTextField(title: "Email", input: $vm.email, keyBoardType: .emailAddress,  error: vm.errorBinding(for: "email"))
            
            TitileTextField(title: "DOB", input: $vm.dob,  error: vm.errorBinding(for: "dob"), isReadOnly: true)
                .onTapGesture {
                    vm.showDobPicker.toggle()
                }
            
            TitileTextField(title: "Phone", input: $vm.phoneNumber, keyBoardType: .numberPad,  error: vm.errorBinding(for: "phoneNumber"))
            
            TitileTextField(title: "password", input: $vm.password, keyBoardType: .numberPad,  error: vm.errorBinding(for: "password"))
            
            Button {
                vm.SignUpValidEnterData()
                
                if vm.error == nil {
                    DbTable.shared.AddUser(email:vm.email, userName:vm.userName, password:vm.password, DOB:vm.dob, phone: vm.phoneNumber)
                    
                    path.append(QuizScreens.home(userData: vm.validUserData(email: vm.email) ?? UsersData(id: 1, email: vm.email, userName: vm.userName, password: vm.password, DOB: vm.dob, Phone: vm.phoneNumber)))
                    
                }
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
