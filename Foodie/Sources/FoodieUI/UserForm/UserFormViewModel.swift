import SwiftUI
import FoodieModels
import FoodieServices

@Observable
class UserFormViewModel {
    private let userService = UserService()
    
    var height = 0.0
    var weight = 0.0
    var age = 0
    var sex = Sex.female
    var activityLevel = ActivityLevel.moderativelyActive
    var showAlert = false
    
    init() {}
    
    func handleAppear() {
        let fields = userService.getUserFields()
        
        height = fields.height ?? height
        weight = fields.weight ?? weight
        age = fields.age ?? age
        sex = fields.sex ?? sex
        activityLevel = fields.activityLevel ?? activityLevel
    }
    
    func submit(_ navigator: Navigator) {
        guard height > 0 && weight > 0 && age > 0 else {
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
