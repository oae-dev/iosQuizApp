//
//  ProfileViewModel.swift
//  RegisterScreen
//
//  Created by Dev on 17/09/25.
//

import Foundation
import UIKit
import _PhotosUI_SwiftUI

class ProfileViewModel: ObservableObject{
    @Published var showPopUp:Bool = false
    @Published var showImagePicker:Bool = false
    @Published var showDatePicker:Bool = false
    @Published var selectedItem: PhotosPickerItem?
    @Published var profileImage: UIImage?
    @Published var date: Date = Date()
    @Published var email:String = ""
    @Published var dob:String = ""
    @Published var phoneNumber:String = ""
    @Published var userName: String = ""
    
    @Published var editDob:Bool = false
    @Published var editPhoneNumber:Bool = false
    @Published var editUserName:Bool = false
    @Published var editEmail:Bool = false
    
   
    
    init(userData:UsersInfo){
        self.userName = userData.userName ?? ""
        self.dob = userData.dob ?? ""
        self.email = userData.email ?? ""
        self.phoneNumber = userData.phoneNumber ?? ""
    }
    
    func formater(date: Date) -> String {
        let formater = DateFormatter()
        formater.dateFormat = "dd MMM, YYYY"
        return formater.string(from: date)
    }
    
//    func userDataChanged(user: UsersData) -> Bool {
//        let matched = user.email == self.email && user.userName == self.userName && user.DOB == self.dob && user.Phone == self.phoneNumber
//        return matched
//    }
}
