//
//  loginViewModel.swift
//  RegisterScreen
//
//  Created by Sequoia on 19/09/25.
//

import Foundation
import _PhotosUI_SwiftUI

class loginViewModel: ObservableObject{
    @Published var showImagePicker:Bool = false
    @Published var selectedItem: PhotosPickerItem?
    @Published var profileImage: UIImage?
    @Published var email:String = ""
    @Published var dob:String = ""
    @Published var phoneNumber:String = ""
    @Published var userName: String = ""
    @Published var password: String = ""
}
