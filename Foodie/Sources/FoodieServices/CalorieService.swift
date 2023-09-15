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
        heightCm: Double,
        weightKg: Double,
        age: Int,
        sex: Sex,
        activityLevel: ActivityLevel
    ) -> Double? {
        let heightInches = self.inchesFrom(cm: heightCm)
        let weightPounds = self.poundsFrom(kg: weightKg)
        
        guard let bmr = calculateBasalMetabolicRate(
            heightInches: heightInches,
            weightPounds: weightPounds,
            age: age,
            sex: sex
        ) else { return nil }
        return bmr * activityLevel.bmrPoints
    }
    
    private func calculateBasalMetabolicRate(
        heightInches: Double,
        weightPounds: Double,
        age: Int,
        sex: Sex
    ) -> Double? {
        guard heightInches > 0 else { return nil }
        guard weightPounds > 0 else { return nil }
        guard age > 0 else { return nil }
        
        // More information found at:
        // https://www.medicalnewstoday.com/articles/319731#calculating-how-many-calories-are-burned-in-a-day
        switch sex {
        case .female, .other:
            // 655.1 + (4.35 * weight) + (4.7 * height) – (4.7 * age)
            let weightPart = 4.35 * weightPounds
            let heightPart = 4.7 * heightInches
            let agePart = 4.7 * Double(age)
            return 655.1 + weightPart + heightPart - agePart
        case .male:
            // 66 + (6.2 * weight) + (12.7 * height) – (6.76 * age)
            let weightPart = 6.2 * weightPounds
            let heightPart = 12.7 * heightInches
            let agePart = 6.76 * Double(age)
            return 66 + weightPart + heightPart - agePart
        }
    }
    
    private func inchesFrom(cm value: Double) -> Double {
        value * 0.393701
    }
    
    private func poundsFrom(kg value: Double) -> Double {
        value * 2.2
    }
}
