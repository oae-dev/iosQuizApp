//
//  Settings.swift
//  RegisterScreen
//
//  Created by Dev on 29/09/25.
//

import SwiftUI

struct Settings: View {
    @Binding var path : NavigationPath
    let user: UsersInfo
    @AppStorage("isLoggedIn") var isLoggedIn: Bool = true
    
    private var settingsList: [SettingsItem] {
        [
            SettingsItem(icon: "person.crop.circle.fill", title: "Profile",
                        destination: AnyView(profileScreen(userData: user))),
            
            SettingsItem(icon: "bell.fill", title: "Notifications",
                        destination: AnyView(Notifications())),
            
            SettingsItem(icon: "eye.circle", title: "Preferences",
                        destination: AnyView(Preferences())),
            
            SettingsItem(icon: "questionmark.circle.fill", title: "About",
                         destination: AnyView(About()))
        ]
    }
    
    var body: some View {
        VStack(alignment: .center, spacing: 45) {
            Text("Settings")
                .font(.system(size: 30, weight: .bold))
                
            VStack(spacing: 25){
                ForEach(settingsList) { list in
                    NavigationLink(destination: list.destination) {
                        labelCell(logo: list.icon, title: list.title)
                    }
                }
                labelCell(logo: "power.circle.fill", title: "Logout")
                    .onTapGesture {
                        isLoggedIn = false
                        path.removeLast()
                    }
            }
            .padding(.horizontal)
            Spacer()
        }
        .frame(maxWidth: .infinity,alignment: .leading)
        .padding(.horizontal)
        
    }
}

#Preview {
    let context = CoreDataManager.shared.container.viewContext
    
    let previewUser = UsersInfo(context: context)
    previewUser.email = "test@example.com"
    previewUser.userName = "PreviewUser"
    previewUser.password = "123456"
    previewUser.dob = "01 Jan, 2000"
    previewUser.phoneNumber = "1234567890"
    
    return Settings(path: .constant(NavigationPath()), user: previewUser)
}
