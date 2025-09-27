//
//  loginViewModel.swift
//  RegisterScreen
//
//  Created by Sequoia on 19/09/25.
//

import Foundation
import _PhotosUI_SwiftUI
import SwiftUI

class loginViewModel: ObservableObject{
    @Published var showImagePicker:Bool = false
    @Published var selectedItem: PhotosPickerItem?
    @Published var profileImage: UIImage?
    @Published var email:String = ""
    @Published var dob:String = ""
    @Published var phoneNumber:String = ""
    @Published var userName: String = ""
    @Published var password: String = ""
    let users = DbTable.shared.FetchUsers()
  
    
    @Published var showDobPicker: Bool = false
    @Published var date: Date = Date()
    
    @Published var error : [String : String]? = nil
    
    func SignUpValidEnterData() {
        var err: [String:String] = [:]
        
        if !emailValid(email: email) {
            err["email"] = "Invalid email address"
        }
        if !phoneNumberValid(phNumber: phoneNumber) {
            err["phoneNumber"] = "Invalid PhoneNumber"
        }
        if !userNameValid(userName: userName) {
            err["userName"] = "Invalid Username"
        }
        if !passwordValid(password: password) {
            err["password"] = "Invalid Password (at least 6 characters)"
        }
        if !dobValid(dob: dob) {
            err["dob"] = "Select DOB"
        }
        self.error = err.isEmpty ? nil : err
    }
    
    func LoginValidEnterData() {
        var err: [String:String] = [:]
        
        if !validLoginEmail(email: email) {
            err["loginEmail"] = "Invalid Email/Username"
        }
        if !validLoginPassword(email: email, password: password) {
            err["loginPassword"] = "Invalid Password"
        }
        self.error = err.isEmpty ? nil : err
    }
    
    func validUserData(email: String) -> UsersData? {
        if let userByEmail = users.first(where: { $0.email == email }) {
              return userByEmail
          }
          
          if let userByUsername = users.first(where: { $0.userName == email }) {
              return userByUsername
          }
          
          // No match found
          return nil
    }
    
    func emailValid(email: String) -> Bool {
        let regex = #"^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$"#
        return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: email)
    }

    func phoneNumberValid(phNumber:String) -> Bool {
        return phNumber.count >= 10
    }

    func passwordValid(password:String) -> Bool {
        return password.count >= 6
    }

    func userNameValid(userName:String) -> Bool {
        return userName.count >= 3
    }
    
    func dobValid(dob:String) -> Bool {
        return !dob.isEmpty
    }
    
    func formater(date: Date) -> String {
        let formater = DateFormatter()
        formater.dateFormat = "dd MMM, YYYY"
        return formater.string(from: date)
    }
    
    func validLoginEmail(email: String) -> Bool {
        let valid = users.contains { user in
            user.userName == email
        } || users.contains(where: { user in
            user.email == email
        })
        
        return valid
    }
    
    func validLoginPassword(email: String, password: String) -> Bool {
        return users.contains { user in
               (user.email == email || user.userName == email) && user.password == password
           }
    }
    
    func errorBinding(for key: String) -> Binding<String?> {
        Binding<String?>(
            get: { self.error?[key] },
            set: { self.error?[key] = $0 }
        )
    }
}
