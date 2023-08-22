import SwiftUI
import SwiftData
import FoodieModels

struct FoodEditor: View {
    @Environment(Navigator.self) var navigator: Navigator
    @Environment(\.modelContext) private var modelContext: ModelContext
    @State var name: String = ""
    
    var body: some View {
        Form {
            TextField("Food", text: $name)
            Button("Add") {
                addFood()
            }.disabled(name.isEmpty)
            Button("Cancel", role: .destructive) {
                navigator.pop()
            }
        }
    }
    
    func addFood() {
//        TODO: Broken in xcode 15 beta 6
//        let food = Food(name: name)
//        modelContext.insert(food)
        navigator.pop()
    }
}
