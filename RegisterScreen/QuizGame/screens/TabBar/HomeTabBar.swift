//
//  HomeTabBar.swift
//  RegisterScreen
//
//  Created by Sequoia on 12/09/25.
//

import SwiftUI

struct HomeTabBar: View {
    @Binding var path: NavigationPath
    let userData: UsersInfo
    
    var body: some View {
        TabView {
            Tab ("Home", systemImage: "house.circle.fill") {
                HomeScreen(path: $path, userData: userData)
            }
            
            Tab(role: .search){
                SearchScreen(path: $path, userData: userData)
            }
            
            Tab ("Results", systemImage: "trophy.fill"){
                TotalResultsScreen()
            }

            
            Tab ("Settings", systemImage: "gear"){
                Settings(path: $path, user: userData)
            }

        }
        .navigationBarBackButtonHidden()
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
    
    return HomeTabBar(path: .constant(NavigationPath()), userData: previewUser)
}
