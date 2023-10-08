import FoodieModels
import Foundation

public class CalorieService {

    public init() {}
    
    public static func dailyRecommendedMass(for nutrient: Nutrient, user: User) -> Measurement<UnitMass> {
        switch nutrient {
        case .protein:
            (user.weight.converted(to: .kilograms) * 0.75).converted(to: .grams)
        case .sodium:
            Measurement<UnitMass>(value: 2300, unit: .milligrams)
        }
    }
    
    public func estimateDailyCalories(for user: User) -> Double {
        let bmr = calculateBasalMetabolicRate(for: user)
        return bmr * user.activityLevel.bmrPoints
    }
    
    private func calculateBasalMetabolicRate(for user: User) -> Double {
        assert(user.height.value > 0)
        assert(user.weight.value > 0)
        assert(user.age > 0)
        
        // More information found at:
        // https://www.medicalnewstoday.com/articles/319731#calculating-how-many-calories-are-burned-in-a-day
        switch user.sex {
        case .female, .other:
            // 655.1 + (4.35 * weight) + (4.7 * height) – (4.7 * age)
            let weightPart = 4.35 * user.weight.converted(to: .pounds).value
            let heightPart = 4.7 * user.height.converted(to: .inches).value
            let agePart = 4.7 * Double(user.age)
            return 655.1 + weightPart + heightPart - agePart
        case .male:
            // 66 + (6.2 * weight) + (12.7 * height) – (6.76 * age)
            let weightPart = 6.2 * user.weight.converted(to: .pounds).value
            let heightPart = 12.7 * user.height.converted(to: .inches).value
            let agePart = 6.76 * Double(user.age)
            return 66 + weightPart + heightPart - agePart
        }
    }
}
