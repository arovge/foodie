import Foundation

public struct User: Hashable {
    public let height: Measurement<UnitLength>
    public let weight: Measurement<UnitMass>
    public let age: Int
    public let sex: Sex
    public let activityLevel: ActivityLevel
    
    public init(height: Measurement<UnitLength>, weight: Measurement<UnitMass>, age: Int, sex: Sex, activityLevel: ActivityLevel) {
        self.height = height
        self.weight = weight
        self.age = age
        self.sex = sex
        self.activityLevel = activityLevel
    }
}
