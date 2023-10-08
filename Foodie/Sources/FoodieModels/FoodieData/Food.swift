import SwiftData
import Foundation

@Model
final public class Food: Hashable {
    public var name: String
    public var calories: Double
    public var protein: Double
    public var sugar: Double
    public var carbs: Double
    
    public init(name: String, calories: Double, protein: Double, sugar: Double, carbs: Double) {
        self.name = name
        self.calories = calories
        self.protein = protein
        self.sugar = sugar
        self.carbs = carbs
    }
}

struct NutritionLabel {
    public let name: String
    public let calories: Double
    public let fat: Fats
    public let cholesterol: Measurement<UnitMass>
    public let sodium: Measurement<UnitMass>
    public let carbs: Carbs
    public let sugars: Sugars
    public let protein: Measurement<UnitMass>
    public let vitamins: Vitamins
}

struct Fats {
    public let total: Measurement<UnitMass>
    public let saturated: Measurement<UnitMass>
    public let trans: Measurement<UnitMass>
}

struct Carbs {
    public let total: Measurement<UnitMass>
    public let fiber: Measurement<UnitMass>
}

struct Sugars {
    public let total: Measurement<UnitMass>
    public let added: Measurement<UnitMass>
}

struct Vitamins {
    public let d: Measurement<UnitMass>
    public let calcium: Measurement<UnitMass>
    public let iron: Measurement<UnitMass>
    public let potassium: Measurement<UnitMass>
}
