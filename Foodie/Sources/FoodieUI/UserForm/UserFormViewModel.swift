import SwiftUI
import FoodieModels
import FoodieServices

@Observable
class UserFormViewModel {
    private let userDefaultsService = UserDefaultsService()
    public var height = 0
    public var weight = 0
    public var age = 0
    public var sex = Sex.female
    public var activityLevel = ActivityLevel.moderativelyActive
    public var showAlert = false
    
    init() {}
    
    func handleAppear() {
        height = userDefaultsService.get(.height) ?? 0
        weight = userDefaultsService.get(.weight) ?? 0
        age = userDefaultsService.get(.age) ?? 0
        let sexValue: Int? = userDefaultsService.get(.sex)
        if let sexValue, let existingSex = Sex(rawValue: sexValue) {
            sex = existingSex
        }
        let activityLevelValue: Int? = userDefaultsService.get(.activityLevel)
        if let activityLevelValue, let existingActivityLevel = ActivityLevel(rawValue: activityLevelValue) {
            activityLevel = existingActivityLevel
        }
    }
    
    func submit(_ navigator: Navigator) {
        guard weight > 0 && height > 0 && age > 0 else {
            showAlert = true
            return
        }
        
        userDefaultsService.set(.weight, value: weight)
        userDefaultsService.set(.height, value: height)
        userDefaultsService.set(.age, value: age)
        userDefaultsService.set(.sex, value: sex.rawValue)
        userDefaultsService.set(.activityLevel, value: activityLevel.rawValue)
        
        let user = User(
            height: .init(value: Double(height), unit: .centimeters),
            weight: .init(value: Double(weight), unit: .kilograms),
            age: age,
            sex: sex,
            activityLevel: activityLevel
        )
        navigator.replaceAll(.dashboard(user))
    }
}
