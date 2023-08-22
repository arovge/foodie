import Foundation

public class UserDefaultsService {
    public init() {}
    
    func get<T>(_ key: Key) -> T? {
        UserDefaults.standard.data(forKey: key.rawValue) as? T
    }
    
    func set<T>(_ key: Key, value: T) {
        UserDefaults.standard.setValue(value, forKey: key.rawValue)
    }
}

enum Key: String {
    case height
    case weight
    case age
    case sex
}
