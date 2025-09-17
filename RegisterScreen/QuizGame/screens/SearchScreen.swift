//
//  SearchScreen.swift
//  RegisterScreen
//
//  Created by Dev on 15/09/25.
//

import SwiftUI

struct SearchScreen: View {
    @Binding var path: NavigationPath
    @ObservedObject var vm = SearchViewModel()
    let userData: UserData
    
    var selectedConfigs: [QuizScreenConfig] {
        (vm.quizzes)
            .filter { $0.selected }
            .compactMap { QuizScreensConfigurator(quiz: $0).quizConfig().first }
    }
    
    var body: some View {
        ZStack {
            ScrollView{
                SearchBar(value: $vm.search) {
                    Task {
                        vm.quizzes.removeAll()
                        vm.loader = true
                        await vm.fetchQuiz()
                        vm.loader = false
                        vm.search = ""
                    }
                }
                
                VStack {
                    if vm.loader{
                        ProgressView()
                    }
                    
                    if !vm.errorMessage.isEmpty {
                        Text(vm.errorMessage)
                            .foregroundColor(.red)
                    }
                }
                
                
                
                if !vm.quizzes.isEmpty {LazyVGrid(columns: [GridItem(.flexible()),
                                                            GridItem(.flexible())]) {
                    ForEach(Array(vm.quizzes.enumerated()), id: \.element.id) { index, quiz in
                        BoxSelector(
                            selected: quiz.selected,
                            ontap: { vm.quizzes[index].selected.toggle() },
                            quiztitle: quiz.title,
                            bg: Color.pink
                        )
                    }
                }
                }
            }
            .padding()
            if !selectedConfigs.isEmpty{
                VStack{
                    Spacer()
                    if !vm.quizzes.isEmpty{
                        Button {
                            if !selectedConfigs.isEmpty {
                                path.append(QuizScreens.gameScreen(selectedConfigs, userName: userData.name))
                                print(selectedConfigs)
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                   for index in vm.quizzes.indices {
                                       vm.quizzes[index].selected = false
                                   }
                               }
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
            }
            
                }
            }
        }
        
    }
}

#Preview {
    SearchScreen(path: .constant(NavigationPath()), userData: UserData(name: "da", age: "33"))
}
