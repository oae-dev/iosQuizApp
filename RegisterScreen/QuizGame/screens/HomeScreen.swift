//
//  HomeScreen.swift
//  RegisterScreen
//
//  Created by Sequoia on 08/09/25.
//

import SwiftUI


struct HomeScreen: View {
    @Binding var path: NavigationPath
    let userData: UserData
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    @State var quizzes: [QuizDetailInfo] = [
        QuizDetailInfo(
            id: "1",
            title: "Basic Math",
            type: "math",
            questions: [
                QuizQuestion(
                    id: "1", question: "What is 2 + 2?",
                    options: ["3", "4", "5", "6"],
                    correctAnswer: "4"
                ),
                QuizQuestion(
                    id: "2", question: "What is 10 ÷ 2?",
                    options: ["2", "4", "5", "10"],
                    correctAnswer: "5"
                ),
                QuizQuestion(
                    id: "3", question: "What is 5 × 3?",
                    options: ["8", "10", "15", "20"],
                    correctAnswer: "15"
                )
            ],
            selected: false
        ),
        QuizDetailInfo(
            id: "2",
            title: "World History",
            type: "history",
            questions: [
                QuizQuestion(
                    id: "3", question: "Who was the first US president?",
                    options: ["George Washington", "Abraham Lincoln", "John Adams", "Thomas Jefferson"],
                    correctAnswer: "George Washington"
                ),
                QuizQuestion(
                    id: "2", question: "When did World War II start?",
                    options: ["1914", "1939", "1945", "1960"],
                    correctAnswer: "1939"
                ),
                QuizQuestion(
                    id: "3", question: "Who built the pyramids?",
                    options: ["Romans", "Greeks", "Egyptians", "Mayans"],
                    correctAnswer: "Egyptians"
                )
            ],
            selected: false
        ),
        QuizDetailInfo(
            id: "3",
            title: "Advanced Math",
            type: "math",
            questions: [
                QuizQuestion(
                    id: "3", question: "Solve for x: 2x + 3 = 7",
                    options: ["x = 1", "x = 2", "x = 3", "x = 4"],
                    correctAnswer: "x = 2"
                ),
                QuizQuestion(
                    id: "4", question: "What is ∫x² dx?",
                    options: ["x³/3 + C", "2x", "x²/2 + C", "ln(x)"],
                    correctAnswer: "x³/3 + C"
                ),
                QuizQuestion(
                    id: "2", question: "What is d/dx of sin(x)?",
                    options: ["cos(x)", "-cos(x)", "sin(x)", "-sin(x)"],
                    correctAnswer: "cos(x)"
                )
            ],
            selected: false
        ),
        QuizDetailInfo(
            id: "4",
            title: "Modern History",
            type: "history",
            questions: [
                QuizQuestion(
                    id: "34", question: "When did India gain independence?",
                    options: ["1947", "1950", "1939", "1965"],
                    correctAnswer: "1947"
                ),
                QuizQuestion(
                    id: "s34", question: "Who was Napoleon?",
                    options: ["French Emperor", "Italian Explorer", "German Chancellor", "Russian Tsar"],
                    correctAnswer: "French Emperor"
                ),
                QuizQuestion(
                    id: "34", question: "When did the Cold War end?",
                    options: ["1989", "1945", "1962", "2001"],
                    correctAnswer: "1989"
                )
            ],
            selected: false
        )
    ]
    var allQuizConfigs: [[QuizScreenConfig]] {
        quizzes.map { quiz in
            let configurator = QuizScreensConfigurator(quiz: quiz)
            return configurator.quizConfig()
        }
    }
    @ObservedObject var vm = HomeViewModel()
    
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
                
                SearchBar(value: $vm.search) {
                    Task {
                        print("click")
                        vm.openSheet = true
                        vm.loader = true
                        await vm.fetchQuiz()
                        vm.loader = false
                        
                    }
                }
                
                VStack(alignment: .center){
                    Text("Chose your Options")
                        .font(.system(size: 20, weight: .heavy))
                        .padding(.bottom, 10)
                }
                .frame(maxWidth: .infinity)
                
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(0..<allQuizConfigs.count, id: \.self) { index in
                        BoxSelector(selected: quizzes[index].selected,
                                    ontap:{
                            quizzes[index].selected.toggle()
                        },
                                    quiztitle: quizzes[index].title, bg: vm.colors[index])
                    }
                }
                Spacer()
                
                Button {
                    let selectedIndex = quizzes.indices.filter{quizzes[$0].selected}
                    let selectedConfig = selectedIndex.flatMap{allQuizConfigs[$0]}
                    if selectedIndex.count > 0 {
                        path.append(QuizScreens.gameScreen(selectedConfig, userName: userData.name))
                    }
                    print("\(selectedConfig)")
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
            .sheet(isPresented: $vm.openSheet,
                   onDismiss: {
                vm.errorMessage = ""
                vm.quizzes.removeAll()
            }
            ) {
                ScrollView{
                        if vm.loader{
                            ProgressView()
                        }
                        if !vm.errorMessage.isEmpty {
                            Text(vm.errorMessage)
                                .foregroundColor(.red)
                        }
                        LazyVGrid(columns: [GridItem(.flexible()),
                                            GridItem(.flexible())], pinnedViews: [.sectionHeaders])) {
                            Section{
                                ForEach(Array(vm.quizzes.enumerated()), id: \.element.id) { index, quiz in
                                    BoxSelector(selected: quiz.selected,
                                                ontap: { vm.quizzes[index].selected.toggle() },
                                                quiztitle: quiz.title,
                                                bg: Color.pink)
                                }
                                header {
                                    Text("All Available Games")
                                        .font(.headline)
                                        .padding()
                                }
                            }
                            
                            
                            
                        }
                    }
                }
                .safeAreaInset(edge: .bottom) {
                    Button {
                        let selectedIndex = quizzes.indices.filter{quizzes[$0].selected}
                        let selectedConfig = selectedIndex.flatMap{allQuizConfigs[$0]}
                        if selectedIndex.count > 0 {
                            path.append(QuizScreens.gameScreen(selectedConfig, userName: userData.name))
                        }
                        print("\(selectedConfig)")
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
                    .padding()
                }
                
            }
            
        }
        .padding()
        .navigationTitle("")
        .navigationBarBackButtonHidden()
        .frame(maxWidth: .infinity)
        .background(
            LinearGradient(colors: [.green, .red, .yellow, .accentColor], startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()
                .padding(.bottom, 1)
        )
        
        
        
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

