//
//  loginViewModel.swift
//  RegisterScreen
//
//  Created by Sequoia on 19/09/25.
//

import Foundation
import SwiftUI
import PhotosUI

class loginViewModel: ObservableObject {
    // MARK: - Published Properties
    @Published var isSignUpPage: Bool = false
    @Published var showImagePicker: Bool = false
    @Published var selectedItem: PhotosPickerItem?
    @Published var profileImage: UIImage?
    
    @Published var email: String = ""
    @Published var dob: String = ""
    @Published var phoneNumber: String = ""
    @Published var userName: String = ""
    @Published var password: String = ""
    
    @Published var showDobPicker: Bool = false
    @Published var date: Date = Date()
    
    @Published var error: [String: String]? = nil
    @Published var users: [UsersInfo] = []
    
   
    // MARK: - Load Users
    func loadUsers() {
        users = CoreDataManager.shared.fetchUsers()
    }
    
    // MARK: - SignUp Validation
    func validateSignUpData() {
        var err: [String: String] = [:]
        
        if !emailValid(email: email) {
            err["email"] = "Invalid email address"
        }
        if !phoneNumberValid(phNumber: phoneNumber) {
            err["phoneNumber"] = "Invalid Phone Number"
        }
        if !userNameValid(userName: userName) {
            err["userName"] = "Invalid Username"
        }
        if !passwordValid(password: password) {
            err["password"] = "Password must be at least 6 characters"
        }
        if !dobValid(dob: dob) {
            err["dob"] = "Please select DOB"
        }
        
        self.error = err.isEmpty ? nil : err
    }
    
    // MARK: - Login Validation
    func LoginValidEnterData() {
        var err: [String: String] = [:]
        
        if !validLoginIdentifier(emailOrUser: email) {
            err["loginEmail"] = "Invalid Email/Username"
        }
        if !validLoginPassword(emailOrUser: email, password: password) {
            err["loginPassword"] = "Invalid Password"
        }
        
        self.error = err.isEmpty ? nil : err
    }
    
    // MARK: - Find user by Email/Username
    func validUserData(emailOrUser: String) -> UsersInfo? {
        if let userByEmail = users.first(where: { $0.email == emailOrUser }) {
            return userByEmail
        }
        if let userByUsername = users.first(where: { $0.userName == emailOrUser }) {
            return userByUsername
        }
        return nil
    }
    
    func emailValid(email: String) -> Bool {
        let regex = #"^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$"#
        return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: email)
    }

    func phoneNumberValid(phNumber: String) -> Bool {
        return phNumber.count >= 10
    }

    func passwordValid(password: String) -> Bool {
        return password.count >= 6
    }

    func userNameValid(userName: String) -> Bool {
        return userName.count >= 3
    }
    
    func dobValid(dob: String) -> Bool {
        return !dob.isEmpty
    }
    
    func formater(date: Date) -> String {
        let formater = DateFormatter()
        formater.dateFormat = "dd MMM, YYYY"
        return formater.string(from: date)
    }
    
    // MARK: - Login Checks
    func validLoginIdentifier(emailOrUser: String) -> Bool {
        return users.contains { $0.userName == emailOrUser || $0.email == emailOrUser }
    }
    
    func validLoginPassword(emailOrUser: String, password: String) -> Bool {
        return users.contains { user in
            (user.userName == emailOrUser || user.email == emailOrUser) && user.password == password
        }
    }
    
    // MARK: - Error Binding
    func errorBinding(for key: String) -> Binding<String?> {
        Binding<String?>(
            get: { self.error?[key] },
            set: { self.error?[key] = $0 }
        )
    }
}

