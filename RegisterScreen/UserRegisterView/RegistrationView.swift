// // RegistrationView.swift // ios26 // // Created by Dev on 06/09/25. //
import SwiftUI

enum SelectedPickers{
    case childrens
    case ageGroup
    case dateOfBirth
}

struct RegistrationView: View {
    @StateObject var viewModel = RegistrationViewModel()
    var body: some View {
        ScrollView{
            VStack(alignment: .leading) {
                Text("User Details")
                    .font(.system(size: 20, weight: .bold))
                    .padding(.bottom, 10)
                InformationView
                ChildrenPickerField(
                    title: "Number of Childrens",
                    value: $viewModel.numberOfChildern,
                    placeHolder: "1") {
                        viewModel.showPicker = true
                        viewModel.selectedPicker = .childrens
                    }
                    .onChange(of: viewModel.numberOfChildern) { newValue in
                        guard let count = newValue else { return }
                        if viewModel.childrensData.count < count {
                            for _ in viewModel.childrensData.count..<count {
                                viewModel.childrensData.append(
                                    ChildrenDetail(childrenName: "", ageGroup: "", dateOfBirth: "")
                                )
                            }
                        } else if viewModel.childrensData.count > count {
                            // Remove extra children
                            viewModel.childrensData.removeLast(viewModel.childrensData.count - count)
                        }
                    }
                if let count = viewModel.numberOfChildern, count > 0 {
                    ForEach(0..<count, id: \.self) { index in
                        ChildrenView( viewModel:viewModel , child: $viewModel.childrensData[index], indexIs: index) }
                }
                Button("proceed") {
                    print("output\(viewModel.childrensData)")
                }.buttonStyle(.borderedProminent)
            }.padding(.horizontal,20)
        }.sheet(isPresented: $viewModel.showPicker,
                onDismiss: { viewModel.showNumberOfChildrenPicker = false
            viewModel.showAgeGroupPicker = false
            
            viewModel.showDateOfBirthPicker = false }){
                VStack{
                    switch viewModel.selectedPicker {
                    case .childrens:
                        PickerHeader()
                        ChildrenPicker(value: ($viewModel.numberOfChildern),
                                       PickerValues: Array(0..<10))
                    case .ageGroup:
                        PickerHeader()
                        AgeGroupPicker(value: $viewModel.childrensData[viewModel.currentChildren].ageGroup,
                                       pickerValues: ["Age Group 1-2", "Age Group 3-5", "Age Group 6-10"])
                    case .dateOfBirth:
                        PickerHeader()
                        MyDatePicker(value: $viewModel.childrensData[viewModel.currentChildren].dateOfBirth)
                    case .none:
                        EmptyView()
                    }
                }.presentationDetents([.fraction(0.4), .medium])
                    .frame(maxHeight: .infinity)
                    .background(Color.black)
            }
    }
    var InformationView: some View{
        VStack {
            TitileTextField(title: "Name", input: $viewModel.name, unValid: .constant(false))
            
            TitileTextField(title: "Email", input: $viewModel.email, unValid: .constant(false))
            
            TitileTextField(title: "Adress", input: $viewModel.adress, unValid: .constant(false))
            
            TitileTextField(title: "PhoneNumber", input: $viewModel.phoneNumber, unValid: .constant(false))
            
            TitileTextField(title: "State", input: $viewModel.state, unValid: .constant(false))
                .onTapGesture { print("open")
                }
        }
    }
}
#Preview {
    RegistrationView()
}

struct ChildrenView: View {
    @ObservedObject var viewModel: RegistrationViewModel
    @Binding var child: ChildrenDetail
    var indexIs: Int
    var body: some View{
        VStack{
            TitileTextField(title: "Name of Children", input: $child.childrenName, unValid: .constant(false))
            
            PickerField(title: "Age Group", value: $child.ageGroup,
                        placeHolder: "Age group 1-5") {
                viewModel.currentChildren = indexIs
                viewModel.showPicker = true
                viewModel.selectedPicker = .ageGroup
            }
            PickerField(title: "Date of birth", value: $child.dateOfBirth,
                        placeHolder: "1-sep-2025") {
                viewModel.currentChildren = indexIs
                viewModel.showPicker = true
                viewModel.selectedPicker = .dateOfBirth }
        }
    }
}
