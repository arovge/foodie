import SwiftUI
import FoodieServices
import FoodieModels

struct NutrientProgressBar: View {
    let nutrient: Nutrient
    let value: Measurement<UnitMass>
    let user: User
    
    init(_ nutrient: Nutrient, value: Measurement<UnitMass>, user: User) {
        self.nutrient = nutrient
        self.value = value
        self.user = user
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(nutrient.rawValue)
                Spacer()
                Text(formattedLabel)
            }
            ProgressView(value: progressValue, total: progressTotal)
                .tint(tint)
        }
        .padding(.vertical, 5)
    }
    
    var total: Measurement<UnitMass> {
        CalorieService.dailyRecommendedMass(for: nutrient, user: user)
    }
    
    var formattedLabel: String {
        let formattedValue = fmt(value, omitUnit: true)
        let formattedTotal = fmt(total)
        return "\(formattedValue)/\(formattedTotal)"
    }
    
    var progressValue: Double {
        // ProgressView doesn't like when things go over the total
        min(value.value, total.value)
    }
    
    var progressTotal: Double {
        total.value
    }
    
    var isOverTotal: Bool {
        value.value > total.value
    }
    
    var tint: Color? {
        if isOverTotal {
            .red
        } else {
            nil
        }
    }
    
    func fmt(_ measurement: Measurement<UnitMass>, omitUnit: Bool = false) -> String {
        if omitUnit {
            measurement.value.formatted()
        } else {
            measurement.formatted(.measurement(width: .abbreviated, usage: .asProvided))
        }
    }
}
