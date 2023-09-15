import Foundation

public class UserDefaultsService {
    public init() {}
    
    func get<T>(_ key: UserDefaultsKey) -> T? {
        UserDefaults.standard.data(forKey: key.rawValue) as? T
    }
    
    func set<T>(_ key: UserDefaultsKey, value: T) {
        UserDefaults.standard.setValue(value, forKey: key.rawValue)
    }
}

public enum UserDefaultsKey: String {
    case height
    case weight
    case age
    case sex
    case activityLevel
}
