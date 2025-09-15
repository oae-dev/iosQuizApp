//
//  HomeTabBar.swift
//  RegisterScreen
//
//  Created by Sequoia on 12/09/25.
//

import SwiftUI

struct HomeTabBar: View {
    @Binding var path: NavigationPath
    let userData: UserData
    
    var body: some View {
        TabView {
            Tab {
                HomeScreen(path: $path, userData: userData)
                    .tag(1)
            } label: {
                VStack{
                    Image(systemName: "house.circle.fill")
                        .resizable()
                    Text("Home")
                }
            }
            
            Tab {
                Color.yellow
                    .tag(2)
            } label: {
                VStack{
                    Image(systemName: "trophy.fill")
                    Text("Results")
                }
            }

            
            Tab {
                Color.red
                    .tag(3)
            } label: {
                VStack{
                    Image(systemName: "person.crop.circle.fill")
                        .resizable()
                    Text("profile")
                }
            }

        }
    }
}

#Preview {
    HomeTabBar(path: .constant(NavigationPath()), userData: UserData(name: "lo", age: "12"))
}
