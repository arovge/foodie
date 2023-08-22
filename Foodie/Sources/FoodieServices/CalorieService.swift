import FoodieModels

public class CalorieService {
    public init() {}
    
    func estimateDailyCalories(
        heightInches: Double,
        weightPounds: Double,
        age: UInt, 
        sex: BiologicalSex,
        activityLevel: ActivityLevel
    ) -> Double {
        assert(heightInches > 0)
        assert(weightPounds > 0)
        
        let bmr = calculateBasalMetabolicRate(
            heightInches: heightInches,
            weightPounds: weightPounds,
            age: age,
            sex: sex
        )
        return bmr * activityLevel.bmrPoints
    }
    
    func calculateBasalMetabolicRate(
        heightInches: Double,
        weightPounds: Double,
        age: UInt,
        sex: BiologicalSex
    ) -> Double {
        assert(heightInches > 0)
        assert(weightPounds > 0)
        
        // More information found at:
        // https://www.medicalnewstoday.com/articles/319731#calculating-how-many-calories-are-burned-in-a-day
        switch sex {
        case .male:
            // 66 + (6.2 * weight) + (12.7 * height) – (6.76 * age)
            let weightPart = 6.2 * weightPounds
            let heightPart = 12.7 * heightInches
            let agePart = 6.76 * Double(age)
            return 66 + weightPart + heightPart - agePart
        case .female:
            // 655.1 + (4.35 * weight) + (4.7 * height) – (4.7 * age)
            let weightPart = 4.35 * weightPounds
            let heightPart = 4.7 * heightInches
            let agePart = 4.7 * Double(age)
            return 655.1 + weightPart + heightPart - agePart
        }
    }
}
