//
//  LoginViewModel.swift
//  RegisterScreen
//
//  Created by Sequoia on 06/09/25.
//

import Foundation

class LoginViewModel: ObservableObject{
    @Published var email:String = ""
    @Published var phoneNumber:String = ""
    @Published var password: String = ""
    
    func LoginTap(){
        
    }
}
