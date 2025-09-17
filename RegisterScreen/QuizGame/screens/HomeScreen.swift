//
//  HomeScreen.swift
//  RegisterScreen
//
//  Created by Sequoia on 08/09/25.
//

import SwiftUI


struct HomeScreen: View {
    @Binding var path: NavigationPath
    @Environment(\.dismiss) var dismiss
    @StateObject var vm = HomeViewModel()
    let userData: UserData
    var showPlayButton: Bool {
        !selectedConfigs.isEmpty
    }
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var selectedConfigs: [QuizScreenConfig] {
        (vm.defultQuizzes + vm.historyQuizzes + vm.biologyQuizzes + vm.mathQuizzes)
            .filter { $0.selected }
            .compactMap { QuizScreensConfigurator(quiz: $0).quizConfig().first }
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading){
                HStack (spacing: 15) {
                    Image(uiImage: emojiToImage(emoji: "🥳"))
                        .resizable()
                        .frame(width: 50, height: 50)
                    
                    VStack (alignment: .leading){
                        Text("Welcome to play")
                            .font(.system(size: 15))
                        
                        Text(userData.name)
                            .font(.system(size: 25, weight: .heavy))
                    }
                }
                
                VStack(alignment: .center){
                    Text("Chose your Options")
                        .font(.system(size: 20, weight: .heavy))
                        .padding(.bottom, 10)
                }
                .frame(maxWidth: .infinity)
                
                GameSection(title: "daily ", quizzes: $vm.defultQuizzes, colors: vm.colors)
                if vm.loader{
                    ProgressView()
                } else {
                    GameSection(title: "Math", quizzes: $vm.mathQuizzes, colors: vm.colors)
                    GameSection(title: "History", quizzes: $vm.historyQuizzes, colors: vm.colors)
                    GameSection(title: "Biology", quizzes: $vm.biologyQuizzes, colors: vm.colors)
                }
                Spacer()
                if showPlayButton{
                    Button {
                        if !selectedConfigs.isEmpty {
                            path.append(QuizScreens.gameScreen(selectedConfigs, userName: userData.name))
                            print(selectedConfigs)
                        }
                        print("\(selectedConfigs)")
                    } label: {
                        Text("play")
                            .font(.system(size: 25, weight: .semibold))
                            .foregroundStyle(.white)
                            .padding(.horizontal, 100)
                            .padding(.vertical, 15)
                            .background(
                                Capsule()
                                    .fill(.blue)
                            )
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.bottom)
                }
            }
//            .sheet(isPresented: $vm.openSheet,
//                   onDismiss: {
//                vm.errorMessage = ""
//                vm.quizzes.removeAll()
//            }
//            ) {
//                ScrollView{
//                    
//                    if vm.loader{
//                        ProgressView()
//                    }
//                    if !vm.errorMessage.isEmpty {
//                        Text(vm.errorMessage)
//                            .foregroundColor(.red)
//                    }
//                    if !vm.quizzes.isEmpty {
//                        LazyVStack(pinnedViews: [.sectionHeaders]) {
//                            Section(
//                                header: Text("All Available Games")
//                                    .font(.headline)
//                                    .padding()
//                                    .background(.thickMaterial)
//                            ) {
//                                LazyVGrid(columns: [GridItem(.flexible()),
//                                                    GridItem(.flexible())]) {
//                                    ForEach(Array(vm.quizzes.enumerated()), id: \.element.id) { index, quiz in
//                                        BoxSelector(
//                                            selected: quiz.selected,
//                                            ontap: { vm.quizzes[index].selected.toggle() },
//                                            quiztitle: quiz.title,
//                                            bg: Color.pink
//                                        )
//                                    }
//                                }
//                            }
//                        }
//                    }
//                }
//                .safeAreaInset(edge: .bottom) {
//                    if !vm.quizzes.isEmpty{
//                        Button {
//                            dismiss()
//                            if !selectedConfigs.isEmpty {
//                                path.append(QuizScreens.gameScreen(selectedConfigs, userName: userData.name))
//                                print(selectedConfigs)
//                            }
//                        } label: {
//                            Text("play")
//                                .font(.system(size: 25, weight: .semibold))
//                                .foregroundStyle(.white)
//                                .padding(.horizontal, 100)
//                                .padding(.vertical, 15)
//                                .background(
//                                    Capsule()
//                                        .fill(.blue)
//                                )
//                        }
//                        .frame(maxWidth: .infinity)
//                        .padding()
//                        .background(.thickMaterial)
//                    }
                    
//                }
//                
//            }
            
        }
        .padding()
        .navigationBarBackButtonHidden(true)
        .navigationTitle("")
        .frame(maxWidth: .infinity)
        .background(
            LinearGradient(colors: [.green, .red, .yellow, .accentColor], startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()
                .padding(.bottom, 1)
        )
        .onAppear {
            Task {
                await vm.fetchAllQuizs()
                print(vm.errorMessage)
                
            }
        }
        
        
        
    }
    func emojiToImage(emoji: String, size: CGFloat = 100) -> UIImage {
        let nsString = emoji as NSString
        let font = UIFont.systemFont(ofSize: size)
        let imageSize = nsString.size(withAttributes: [.font: font])
        
        UIGraphicsBeginImageContextWithOptions(imageSize, false, 0)
        nsString.draw(at: .zero, withAttributes: [.font: font])
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image ?? UIImage()
    }
}
#Preview {
    HomeScreen(path: .constant(NavigationPath()), userData: UserData(name: "lovepreetSingh", age: "23"))
}


struct GameSection: View {
    
    let title: String
    @Binding var quizzes: [QuizDetailInfo]
    let colors: [Color]
    
    var body: some View {
        VStack {
            HStack{
                Text(title)
                Spacer()
                Text("view all >")
            }
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    ForEach(quizzes.indices, id: \.self) { index in
                        BoxSelector(selected: quizzes[index].selected,
                                    ontap:{
                            quizzes[index].selected.toggle()
                        },
                                    quiztitle: quizzes[index].title, bg: colors[index])
                    }
                }
            }
        }
    }
}
