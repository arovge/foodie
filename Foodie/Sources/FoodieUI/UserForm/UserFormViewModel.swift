import SwiftUI
import FoodieModels
import FoodieServices

@Observable
class UserFormViewModel {
    private let userService = UserService()
    
    public var height = 0.0
    public var weight = 0.0
    public var age = 0
    public var sex = Sex.female
    public var activityLevel = ActivityLevel.moderativelyActive
    public var showAlert = false
    
    init() {}
    
    func handleAppear() {
        let fields = userService.getUserFields()
        
        if let value = fields.height {
            height = value
        }
        if let value = fields.weight {
            weight = value
        }
        if let value = fields.age {
            age = value
        }
        if let value = fields.sex {
            sex = value
        }
        if let value = fields.activityLevel {
            activityLevel = value
        }
    }
    
    func submit(_ navigator: Navigator) {
        guard weight > 0 && height > 0 && age > 0 else {
            showAlert = true
            return
        }
        
        let user = User(
            height: .init(value: Double(height), unit: .centimeters),
            weight: .init(value: Double(weight), unit: .kilograms),
            age: age,
            sex: sex,
            activityLevel: activityLevel
        )
        userService.save(user)
        navigator.replaceAll(.dashboard(user))
    }
}
