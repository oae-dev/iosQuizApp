//
//  Settings.swift
//  RegisterScreen
//
//  Created by Dev on 29/09/25.
//

import SwiftUI

struct Settings: View {
    @State var path = NavigationPath()
    let user: UsersData
    var body: some View {
        
            NavigationLink(destination: profileScreen(userData: user)) {
                Text("Profile")
                    .foregroundStyle(.black)
            
        }
    }
}

#Preview {
    Settings(user: UsersData(id: 1, email: "", userName: "", password: "", DOB: "", Phone: ""))
}
