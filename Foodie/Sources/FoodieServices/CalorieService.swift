import FoodieModels
import Foundation

public class CalorieService {

    public init() {}
    
    public static func dailyRecommended(_ nutrient: Nutrient) -> Measurement<UnitMass> {
        switch nutrient {
        case .sodium:
            Measurement<UnitMass>(value: 2300, unit: .milligrams)
        }
    }
    
    public func estimateDailyCalories(
        height: Measurement<UnitLength>,
        weight: Measurement<UnitMass>,
        age: Int,
        sex: Sex,
        activityLevel: ActivityLevel
    ) -> Double? {
        guard let bmr = calculateBasalMetabolicRate(
            height: height,
            weight: weight,
            age: age,
            sex: sex
        ) else { return nil }
        return bmr * activityLevel.bmrPoints
    }
    
    private func calculateBasalMetabolicRate(
        height: Measurement<UnitLength>,
        weight: Measurement<UnitMass>,
        age: Int,
        sex: Sex
    ) -> Double? {
        guard height.value > 0 else { return nil }
        guard weight.value > 0 else { return nil }
        guard age > 0 else { return nil }
        
        // More information found at:
        // https://www.medicalnewstoday.com/articles/319731#calculating-how-many-calories-are-burned-in-a-day
        switch sex {
        case .female, .other:
            // 655.1 + (4.35 * weight) + (4.7 * height) – (4.7 * age)
            let weightPart = 4.35 * weight.converted(to: .pounds).value
            let heightPart = 4.7 * height.converted(to: .inches).value
            let agePart = 4.7 * Double(age)
            return 655.1 + weightPart + heightPart - agePart
        case .male:
            // 66 + (6.2 * weight) + (12.7 * height) – (6.76 * age)
            let weightPart = 6.2 * weight.converted(to: .pounds).value
            let heightPart = 12.7 * height.converted(to: .inches).value
            let agePart = 6.76 * Double(age)
            return 66 + weightPart + heightPart - agePart
        }
    }
}
