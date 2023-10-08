import SwiftUI
import FoodieServices
import FoodieModels
import Foundation

@MainActor
class RootViewModel: ObservableObject {
    let userDefaultsService = UserDefaultsService()
    
    func handleAppear(_ navigator: Navigator) {
        if let profile = getUser() {
            navigator.push(.dashboard(profile))
        } else {
            navigator.push(.setup)
        }
    }
    
    private func getUser() -> User? {
        let height: Double? = userDefaultsService.get(.height)
        let weight: Double? = userDefaultsService.get(.weight)
        let age: Int? = userDefaultsService.get(.age)
        let sexValue: Int? = userDefaultsService.get(.sex)
        let activityLevelValue: Int? = userDefaultsService.get(.activityLevel)

        guard let height, height > 0 else { return nil }
        guard let weight, weight > 0 else { return nil }
        guard let age, age > 0 else { return nil }
        guard let sexValue, let sex = Sex(rawValue: sexValue) else { return nil }
        guard let activityLevelValue, let activityLevel = ActivityLevel(rawValue: activityLevelValue) else { return nil }

        return User(
            height: Measurement(value: height, unit: .centimeters),
            weight: Measurement(value: weight, unit: .kilograms),
            age: age,
            sex: sex,
            activityLevel: activityLevel
        )
    }
}
