import FoodieModels
import Foundation

public class UserService {
    let userDefaultsService = UserDefaultsService()
    
    public init() {}
    
    public func getExistingUser() -> User? {
        let fields = getUserFields()

        guard let height = fields.height, height > 0 else { return nil }
        guard let weight = fields.weight, weight > 0 else { return nil }
        guard let age = fields.age, age > 0 else { return nil }
        guard let sex = fields.sex else { return nil }
        guard let activityLevel = fields.activityLevel else { return nil }
        
        return User(
            height: Measurement(value: height, unit: .centimeters),
            weight: Measurement(value: weight, unit: .kilograms),
            age: age,
            sex: sex,
            activityLevel: activityLevel
        )
    }
    
    public func save(_ user: User) {
        userDefaultsService.set(.weight, value: user.weight.value)
        userDefaultsService.set(.height, value: user.height.value)
        userDefaultsService.set(.age, value: user.age)
        userDefaultsService.set(.sex, value: user.sex.rawValue)
        userDefaultsService.set(.activityLevel, value: user.activityLevel.rawValue)
    }
    
    public func getUserFields() -> (height: Double?, weight: Double?, age: Int?, sex: Sex?, activityLevel: ActivityLevel?) {
        let height: Double? = userDefaultsService.get(.height)
        let weight: Double? = userDefaultsService.get(.weight)
        let age: Int? = userDefaultsService.get(.age)
        let sex = getSexField()
        let activityLevel = getActivityLevelField()
        
        return (
            height,
            weight,
            age,
            sex,
            activityLevel
        )
    }
    
    private func getSexField() -> Sex? {
        let value: Int? = userDefaultsService.get(.sex)
        guard let value else { return nil }
        return Sex(rawValue: value)
    }
    
    private func getActivityLevelField() -> ActivityLevel? {
        let value: Int? = userDefaultsService.get(.activityLevel)
        guard let value else { return nil }
        return ActivityLevel(rawValue: value)
    }
}
