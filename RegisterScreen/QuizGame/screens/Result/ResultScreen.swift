//
//  ResultScreen.swift
//  RegisterScreen
//
//  Created by Sequoia on 09/09/25.
//

import SwiftUI

struct ResultScreen: View {
    let score:Int
    let totalQuestions: Int
    let userName: String
    @State var showShareSheet: Bool = false
    @State private var resultImage: UIImage?
    @Binding var path: NavigationPath
    var body: some View {
        VStack {
           let shareView = VStack(spacing: 30){
                scoreChecker(score: score, totalQuestions: totalQuestions)
                    .padding(20)
                
                if totalQuestions / 2 < score{
                    Text("🥳Congratulation🥳")
                        .font(.system(size: 35, weight: .bold))
                    Text("Greatjob, \(userName) you did it !")
                        .font(.system(size: 20))
                } else {
                    Text("It's Bad ☹️")
                        .font(.system(size: 35, weight: .bold))
                    Text("Sorry, \(userName) Try Next Time !")
                        .font(.system(size: 20))
                }
            }
            
            shareView
            
            Spacer()
            VStack(spacing: 20){
                Button {
                    resultImage = shareView.snapshot()
                     
                } label: {
                    Text("Share")
                        .font(.system(size: 25, weight: .semibold))
                        .foregroundStyle(.white)
                        .padding(.horizontal, 100)
                        .padding(.vertical, 15)
                        .background(
                            Capsule()
                                .fill(.blue)
                        )
                }
                
                Button {
                    path.removeLast(2)
                } label: {
                    Text("Done")
                        .font(.system(size: 25, weight: .semibold))
                        .foregroundStyle(.white)
                        .padding(.horizontal, 100)
                        .padding(.vertical, 15)
                        .background(
                            Capsule()
                                .fill(.blue)
                        )
                }
            }.frame(maxWidth: .infinity)
                .padding(.bottom)
        }
        .onChange(of: resultImage, { oldValue, newValue in
            if resultImage != nil {
                showShareSheet = true
            }
        })
        .padding()
        .navigationBarBackButtonHidden()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            LinearGradient(colors: [.green, .red, .yellow, .accentColor], startPoint: .topLeading, endPoint: .bottomTrailing)
        )
        
        .sheet(isPresented: $showShareSheet) {
            if let resultImage {
                    shareSheet(item: [resultImage])
                }
        }
    }
}

#Preview {
    ResultScreen(score: 6, totalQuestions: 10, userName: "lovepreet Singh", path: .constant(NavigationPath()))
}


struct shareSheet: UIViewControllerRepresentable{
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
    
    let item: [Any]
    
    func makeUIViewController(context: Context) -> some UIViewController {
        UIActivityViewController(activityItems: item, applicationActivities: nil) }
    
}

extension View {
    func snapshot(padding: CGFloat = 16) -> UIImage {
        let controller = UIHostingController(rootView: self.padding(.bottom, padding))
        let view = controller.view

        // Make sure the view is properly sized
        let targetSize = controller.sizeThatFits(in: UIScreen.main.bounds.size)
        view?.bounds = CGRect(origin: .zero, size: targetSize)
        view?.backgroundColor = .white
        view?.layoutIfNeeded()

        let renderer = UIGraphicsImageRenderer(size: targetSize)
        return renderer.image { _ in
            view?.drawHierarchy(in: view?.bounds ?? .zero, afterScreenUpdates: true)
        }
    }
}

