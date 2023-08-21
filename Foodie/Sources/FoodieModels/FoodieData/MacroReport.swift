import Foundation
import SwiftData

@Model
final public class MacroReport {
    @Attribute(.unique)
    public let date: Date
    public let calories: Double
    public let recommendedCalories: Double
    
    public init(date: Date, calories: Double) {
        self.date = date
        self.calories = calories
    }
}
