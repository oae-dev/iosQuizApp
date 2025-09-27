//
//  HomeTabBar.swift
//  RegisterScreen
//
//  Created by Sequoia on 12/09/25.
//

import SwiftUI

struct HomeTabBar: View {
    @Binding var path: NavigationPath
    let userData: UsersData
    
    var body: some View {
        TabView {
            Tab ("Home", systemImage: "house.circle.fill") {
                HomeScreen(path: $path, userData: userData)
            }
            
            Tab(role: .search){
                SearchScreen(path: $path, userData: userData)
            }
            
            Tab ("Results", systemImage: "trophy.fill"){
                Color.yellow
            }

            
            Tab ("profile", systemImage: "person.crop.circle.fill"){
                profileScreen(userData: userData)
            }

        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    HomeTabBar(path: .constant(NavigationPath()), userData: UsersData(id: 1, email: "", userName: "", password: "", DOB: "", Phone: ""))
}
