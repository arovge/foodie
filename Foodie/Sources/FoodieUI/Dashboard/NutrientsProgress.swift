import SwiftUI
import FoodieModels

struct NutrientsProgress: View {
    let food: [Food]
    
    var body: some View {
        Section("Nutrients") {
            ForEach(Nutrient.allCases) { nutrient in
                NutrientProgressBar(nutrient, value: value(for: nutrient))
            }
        }
    }
    
    func value(for nutrient: Nutrient) -> Measurement<UnitMass> {
        switch nutrient {
        case .sodium: currentSodium
        }
    }
    
    var currentSodium: Measurement<UnitMass> {
        let sodium = food.reduce(0) { $0 + $1.calories }
        return Measurement<UnitMass>(value: sodium, unit: .milligrams)
    }
}
