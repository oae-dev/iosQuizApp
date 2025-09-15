//
//  RegisterScreenApp.swift
//  RegisterScreen
//
//  Created by Sequoia on 06/09/25.
//

import SwiftUI

enum Screens: Hashable, Codable{
    case home
    case register
}

@main
struct RegisterScreenApp: App {
    @State private var path: [Screens] = []
    var body: some Scene {
        WindowGroup {
            SplashScreen()
//            NavigationStack(path: $path){
////                HomeLoginView(path: $path)
//                RegistrationView()
//            }.navigationDestination(for: Screens.self) { route in
//                switch route {
//                case .home :
//                    HomeLoginView(path: $path)
//                case .register :
//                    RegistrationView()
//                }
//            }
        }
    }
}
