//
//  UserRegistrationViewModel.swift
//  ios26
//
//  Created by Dev on 06/09/25.
//

import Foundation
struct ChildrenDetail: Hashable, Codable{
    var childrenName:String
    var ageGroup:String
    var dateOfBirth:String
}

class RegistrationViewModel: ObservableObject{
    @Published var registerDetail: EventDetails
    @Published var email:String = ""
    @Published var name: String = ""
    @Published var phoneNumber:String = ""
    @Published var state:String = ""
    @Published var adress:String = ""
    @Published var childrensData: [ChildrenDetail] = []
    @Published var currentChildren:Int = 0
    @Published var numberOfChildern: Int? = 0 {
        didSet {
            guard let count = numberOfChildern else { return }
            if childrensData.count < count {
                for _ in childrensData.count..<count {
                    childrensData.append(
                        ChildrenDetail(childrenName: "", ageGroup: "", dateOfBirth: "")
                    )
                }
            } else if childrensData.count > count {
                childrensData.removeLast(childrensData.count - count)
            }
        }
    }
    
    @Published var showNumberOfChildrenPicker: Bool = false
    @Published var showAgeGroupPicker:Bool = false
    @Published var showDateOfBirthPicker:Bool = false
    @Published var showPicker:Bool = false
    @Published var selectedPicker: SelectedPickers? = nil
    
    init() {
            self.registerDetail = EventDetails(
                userDetails: UserDetails(email: "", PhoneNumber: ""),
                state: ""
            )
        }
}
