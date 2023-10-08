import SwiftUI
import SwiftData
import FoodieModels
import SwiftData

private enum Field: Hashable {
    case name
    case calories
    case protein
    case sugar
    case carbs
}

struct FoodEditor: View {
    @Environment(Navigator.self) var navigator: Navigator
    @Environment(\.modelContext) private var modelContext: ModelContext
    @FocusState private var focusedField: Field?
    @State var name: String
    @State var calories: Double
    @State var protein: Double
    @State var sugar: Double
    @State var carbs: Double
    var existingFood: Food?
    
    init(existingFood: Food? = nil) {
        self.existingFood = existingFood
        self._name = .init(initialValue: existingFood?.name ?? "")
        self._calories = .init(initialValue: existingFood?.calories ?? 0)
        self._protein = .init(initialValue: existingFood?.protein ?? 0)
        self._sugar = .init(initialValue: existingFood?.sugar ?? 0)
        self._carbs = .init(initialValue: existingFood?.carbs ?? 0)
    }
    
    var body: some View {
        Form {
            Section("Food") {
                TextField("Food", text: $name)
                    .focused($focusedField, equals: .name)
            }
            Section("Calories") {
                TextField("Calories", value: $calories, format: .number)
                    .focused($focusedField, equals: .calories)
            }
            Section("Protein") {
                TextField("Protein", value: $protein, format: .number)
                    .focused($focusedField, equals: .protein)
            }
            Section("Sugar") {
                TextField("Sugar", value: $sugar, format: .number)
                    .focused($focusedField, equals: .sugar)
            }
            Section("Carbs") {
                TextField("Carbs", value: $carbs, format: .number)
                    .focused($focusedField, equals: .carbs)
            }
            Section {
                Button(primaryActionText) {
                    addFood()
                }
                .disabled(isFormInvalid)
                
                Button("Cancel", role: .destructive) {
                    navigator.pop()
                }
            }
        }
        .navigationTitle(title)
    }
    
    var isEditing: Bool {
        existingFood != nil
    }
    
    var title: String {
        if isEditing {
            "Edit Food"
        } else {
            "Add Food"
        }
    }
    
    var primaryActionText: String {
        if isEditing {
            "Save"
        } else {
            "Add"
        }
    }
    
    func addFood() {
        guard !isFormInvalid else { return }

        let food = Food(
            name: name,
            calories: calories,
            protein: protein,
            sugar: sugar,
            carbs: carbs
        )
        
        // TODO: If existing object, we need to update the original fields on it and call modelContext.save()
        if let existingFood {
            modelContext.delete(existingFood)
        }
        modelContext.insert(food)
        navigator.pop()
    }
    
    var isFormInvalid: Bool {
        name.isEmpty
    }
}
