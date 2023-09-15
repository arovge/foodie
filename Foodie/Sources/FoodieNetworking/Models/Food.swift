public struct Food: Codable {
    let id: Int
    let name: String
    let barcode: String
    let nutrition: NutritionLabel
}
