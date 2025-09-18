//
//  ProfileViewModel.swift
//  RegisterScreen
//
//  Created by Dev on 17/09/25.
//

import Foundation

class ProfileViewModel: ObservableObject{
    @Published var showPopUp:Bool = false
    @Published var email:String = "abc#fds"
    @Published var dob:String = ""
    @Published var phoneNumber:String = ""
}
