import SwiftUI
import FoodieModels

struct NutrientsProgress: View {
    let food: [Food]
    let user: User
    
    var body: some View {
        Section("Nutrients") {
            ForEach(Nutrient.allCases) { nutrient in
                NutrientProgressBar(nutrient, value: value(for: nutrient), user: user)
            }
        }
    }
    
    func value(for nutrient: Nutrient) -> Measurement<UnitMass> {
        switch nutrient {
        case .protein: currentProtein
        case .sodium: currentSodium
        }
    }
    
    var currentProtein: Measurement<UnitMass> {
        let protein = food.reduce(0) { $0 + $1.protein }
        return Measurement<UnitMass>(value: protein, unit: .grams)
    }
    
    var currentSodium: Measurement<UnitMass> {
        let sodium = food.reduce(0) { $0 + $1.calories }
        return Measurement<UnitMass>(value: sodium, unit: .milligrams)
    }
}
