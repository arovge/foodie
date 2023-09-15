public struct NutritionLabel: Codable {
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

public struct Fats: Codable {
    public let total: Double
    public let saturated: Double
    public let trans: Double
}

public struct Carbs: Codable {
    public let total: Double
    public let fiber: Double
}

public struct Sugars: Codable {
    public let total: Double
    public let added: Double
}

public struct Vitamins: Codable {
    public let d: Double
    public let calcium: Double
    public let iron: Double
    public let potassium: Double
}
