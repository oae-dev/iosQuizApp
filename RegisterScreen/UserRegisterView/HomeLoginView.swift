////
////  HomeLoginView.swift
////  ios26
////
////  Created by Dev on 06/09/25.
////
//
//import SwiftUI
//
//struct HomeLoginView: View {
//    @Binding var path: [Screens]
//    @StateObject var viewModel:LoginViewModel = LoginViewModel()
//    var body: some View {
//        VStack(spacing: 12) {
//            Text("Please Login")
//                .font(.title)
//            TitileTextField(title: "Email", input: $viewModel.email, keyBoardType: .emailAddress )
//            TitileTextField(title: "Phone Number", input: $viewModel.phoneNumber, keyBoardType: .phonePad,  )
//            TitileTextField(title: "Password", input: $viewModel.password,secure: true)
//            Button("Login") {
//                path.append(.register)
//            }
//            .buttonStyle(.borderedProminent)
//        }.padding(.horizontal, 20)
//    }
//}
//
//#Preview {
//    HomeLoginView(path: .constant([]))
//}
