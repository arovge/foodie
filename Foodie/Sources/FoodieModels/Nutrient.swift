public enum Nutrient: String, Identifiable, CaseIterable {
    case sodium = "Sodium"
    
    public var id: String {
        rawValue
    }
}
