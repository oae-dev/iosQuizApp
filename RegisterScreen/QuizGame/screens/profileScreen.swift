//
//  profileScreen.swift
//  RegisterScreen
//
//  Created by Dev on 17/09/25.
//

import SwiftUI
import _PhotosUI_SwiftUI

struct profileScreen: View {
    let userData: UsersData
    @StateObject private var vm: ProfileViewModel
    
    init(userData: UsersData) {
        self.userData = userData
        _vm = StateObject(wrappedValue: ProfileViewModel(userData: userData))
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 45){
            Text("Profile")
                .font(.system(size: 40, weight: .bold))
            
            ZStack(alignment: .bottomTrailing) {
                if let profileImage = vm.profileImage {
                    Image(uiImage: profileImage)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 140, height: 140)
                        .clipShape(Circle())
                } else {
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 140, height: 140)
                        .foregroundColor(.gray)
                }
                
                Image(systemName: "plus.circle.fill")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .foregroundStyle(Color.green)
                    .padding(.trailing, 9)
                    .padding(.bottom, 6)
                    .onTapGesture {
                        vm.showPopUp = true
                    }
            }
            .frame(maxWidth: .infinity)
            
            EditTableTextField(title: "UserName", isEdit: $vm.editUserName, field: $vm.userName)
            EditTableTextField(title: "Email", isEdit: $vm.editEmail, field: $vm.email, keyboardType: .emailAddress)
            EditTableTextField(title: "DOB", isEdit: $vm.editDob, field: $vm.dob, onTickPress: {
                vm.showDatePicker = true
            })
            
            EditTableTextField(title: "Phone", isEdit: $vm.editPhoneNumber, field: $vm.phoneNumber, keyboardType: .phonePad)
            
            
            Spacer()
            Button {
                
            } label: {
                Text("save")
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
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal)
        .confirmationDialog("Are You Want to Change Profile Image .", isPresented: $vm.showPopUp, titleVisibility: .visible) {
            Button("Sure") {
                vm.editUserName = false
                vm.showImagePicker = true
                print("upload")
            }
        }
        .sheet(isPresented: $vm.showImagePicker) {
            PhotosPicker("", selection: $vm.selectedItem)
                .photosPickerStyle(.inline)
        }
        .sheet(isPresented: $vm.showDatePicker, onDismiss: {
            vm.editDob = false
        }, content: {
            DatePicker("", selection: $vm.date, displayedComponents: .date)
                .datePickerStyle(.wheel)
                .labelsHidden()
        })
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
        .onChange(of: vm.date) {
            vm.dob = vm.formater(date: vm.date)
        }
    }
    
}

#Preview {
    profileScreen(userData: UsersData(id: 1, email: "", userName: "", password: "", DOB: "", Phone: ""))
}
