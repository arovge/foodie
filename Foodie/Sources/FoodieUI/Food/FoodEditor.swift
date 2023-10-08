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
                Button("Cancel", role: .destructive) {
                    navigator.pop()
                }
                if isEditing {
                    Button("Delete", role: .destructive) {
                        delete()
                    }
                }
            }
        }
        .navigationTitle(title)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button(primaryActionText) {
                    add()
                }
                .disabled(isFormInvalid)
            }
        }
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
    
    func add() {
        guard !isFormInvalid else { return }
        
        if let existingFood {
            existingFood.name = name
            existingFood.calories = calories
            existingFood.protein = protein
            existingFood.sugar = sugar
            existingFood.carbs = carbs
        } else {
            let food = Food(
                name: name,
                calories: calories,
                protein: protein,
                sugar: sugar,
                carbs: carbs
            )
            modelContext.insert(food)
        }
        
        // TODO: Error handling
        try! modelContext.save()

        navigator.pop()
    }
    
    func delete() {
        guard let existingFood else { return }
        modelContext.delete(existingFood)
        navigator.pop()
    }
    
    var isFormInvalid: Bool {
        name.isEmpty
    }
}
