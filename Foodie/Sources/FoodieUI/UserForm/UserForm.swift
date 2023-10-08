import SwiftUI
import FoodieModels
import FoodieServices

private enum Field: Hashable {
    case height
    case weight
    case age
}

struct UserForm: View {
    @Environment(Navigator.self) var navigator: Navigator
    @State var viewModel = UserFormViewModel()
    @FocusState private var focusedField: Field?

    var body: some View {
        Form {
            Section("Height (cm)") {
                TextField("Height (cm)", value: $viewModel.height, format: .number)
                    .focused($focusedField, equals: .height)
            }
            Section("Weight (kg)") {
                TextField("Weight (kg)", value: $viewModel.weight, format: .number)
                    .focused($focusedField, equals: .weight)
            }
            Section("Age (years)") {
                TextField("Age (years)", value: $viewModel.age, format: .number)
                    .focused($focusedField, equals: .age)
            }
            Section("Sex") {
                Picker("Sex", selection: $viewModel.sex) {
                    ForEach(Sex.allCases) { item in
                        Text(item.description)
                            .tag(item)
                    }
                }
                if viewModel.sex == .other {
                    Text("Other will use the same values as 'Female' for calculating your daily recommended calories")
                }
            }
            Section("Activity Level") {
                Picker("Activity Level", selection: $viewModel.activityLevel) {
                    ForEach(ActivityLevel.allCases) { item in
                        Text(item.label)
                            .tag(item)
                    }
                }
                Text(viewModel.activityLevel.description)
            }
        }
        .onAppear {
            viewModel.handleAppear()
        }
        .alert("Invalid values", isPresented: $viewModel.showAlert, presenting: nil) {
            
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Done") {
                    viewModel.submit(navigator)
                }
            }
        }
    }
}
