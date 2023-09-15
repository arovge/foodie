public enum Sex: Int, Identifiable, CaseIterable {
    case female = 1
    case male = 2
    case other = 3
    
    public var id: Int {
        self.rawValue
    }
    
    public var description: String {
        switch self {
        case .female: "Female"
        case .male: "Male"
        case .other: "Other"
        }
    }
}
