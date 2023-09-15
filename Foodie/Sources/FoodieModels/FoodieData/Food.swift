import SwiftData

@Model
final public class Food: Hashable {
    public let name: String
    public let calories: Double
    public let protein: Double
    public let sugar: Double
    public let carbs: Double
    
    public init(name: String, calories: Double, protein: Double, sugar: Double, carbs: Double) {
        self.name = name
        self.calories = calories
        self.protein = protein
        self.sugar = sugar
        self.carbs = carbs
    }
}

// TODO: Either add mg/g to property names or do some type shennanigans instead of using Double everywhere
// Or use Measurement!
struct NutritionLabel {
    public let name: String
    public let calories: Double
    public let fat: Fats
    public let cholesterol: Double
    public let sodium: Double
    public let carbs: Carbs
    public let sugars: Sugars
    public let protein: Double
    public let vitamins: Vitamins
}

struct Fats {
    public let total: Double
    public let saturated: Double
    public let trans: Double
}

struct Carbs {
    public let total: Double
    public let fiber: Double
}

struct Sugars {
    public let total: Double
    public let added: Double
}

struct Vitamins {
    public let d: Double
    public let calcium: Double
    public let iron: Double
    public let potassium: Double
}
