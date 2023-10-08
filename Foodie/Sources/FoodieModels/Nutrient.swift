public enum Nutrient: String, Identifiable, CaseIterable {
    case protein = "Protein"
    case sodium = "Sodium"
    
    public var id: String {
        rawValue
    }
}
