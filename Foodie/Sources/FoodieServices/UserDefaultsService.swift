import Foundation

public class UserDefaultsService {
    public init() {}
    
    public func get<T: Decodable>(_ key: UserDefaultsKey) -> T? {
        guard let value = UserDefaults.standard.data(forKey: key.rawValue) else {
            return nil
        }
        return try! JSONDecoder().decode(T.self, from: value)
    }
    
    public func set<T: Encodable>(_ key: UserDefaultsKey, value: T) {
        let encoded = try! JSONEncoder().encode(value)
        UserDefaults.standard.set(encoded, forKey: key.rawValue)
        UserDefaults.standard.synchronize()
    }
}

public enum UserDefaultsKey: String {
    case height
    case weight
    case age
    case sex
    case activityLevel
}
