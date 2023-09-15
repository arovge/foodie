import SwiftUI

extension Binding where Value == Double {
    public func str() -> Binding<String> {
        .init(get: {
            if wrappedValue == 0 {
                ""
            } else {
                wrappedValue.description
            }
        }, set: {
            guard let value = Double($0) else { return }
            wrappedValue = value
        })
    }
}

extension Binding where Value == Int {
    public func str() -> Binding<String> {
        .init(get: {
            if wrappedValue == 0 {
                ""
            } else {
                wrappedValue.description
            }
        }, set: {
            guard let value = Int($0) else { return }
            wrappedValue = value
        })
    }
}
