import SwiftUI
import FoodieModels

struct NutrientsProgress: View {
    let food: [Food]
    
    var body: some View {
        Section("Nutrients") {
            NutrientProgressBar(.sodium, value: currentSodium)
        }
    }
    
    var currentSodium: Measurement<UnitMass> {
        let sodium = food.reduce(0) { $0 + $1.calories }
        return Measurement<UnitMass>(value: sodium, unit: .milligrams)
    }
}
