//
//  SearchScreen.swift
//  RegisterScreen
//
//  Created by Dev on 15/09/25.
//

import SwiftUI

struct SearchScreen: View {
        @ObservedObject var vm = SearchViewModel()
    
    var body: some View {
        VStack{
            SearchBar(value: $vm.search) {
                Task {
                    vm.loader = true
                    await vm.fetchQuiz()
                    vm.loader = false
                    
                }
            }
        }
    }
}

#Preview {
    SearchScreen()
}
