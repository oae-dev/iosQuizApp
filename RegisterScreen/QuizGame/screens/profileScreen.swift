//
//  profileScreen.swift
//  RegisterScreen
//
//  Created by Dev on 17/09/25.
//

import SwiftUI

struct profileScreen: View {
    let userData: UserData
    @StateObject var vm = ProfileViewModel()
    var body: some View {
        VStack(alignment: .leading, spacing: 15){
            Text("Profile")
                .font(.system(size: 22, weight: .bold))
            
               
            Image("bg")
                .resizable()
                .frame(width: 90, height: 90)
                .clipped()
                .clipShape(
                    Circle()
                )
                .padding(1)
                
                .background(
                    Circle()
                        .foregroundStyle(Color.black)
                )
                .overlay(alignment: .bottomTrailing) {
                    Image(systemName: "plus.circle.fill")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .foregroundStyle(Color.green)
                        .padding(.trailing, 9)
                        .padding(.bottom, 9)
                }
                .frame(maxWidth: .infinity, alignment: .center)
            
            Text(userData.name)
            Text(userData.age)
            myField
            Spacer()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal)
    }
    
    var myField: some View{
        VStack{
            HStack{
                Text("Email: ")
                
                Text(vm.email)
                
                Spacer()
                Image(systemName: "")
            }
            
            Divider()
                .padding(.vertical)
                .foregroundStyle(Color.black)
        }
    }
}

#Preview {
    profileScreen(userData: UserData(name: "lovepreet", age: "34"))
}
