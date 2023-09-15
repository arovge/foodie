import SwiftUI

public enum ImageSymbol: String {
    case exclamationMarkTriangle = "exclamationmark.triangle"
    case gearshapeFill = "gearshape.fill"
    case plus = "plus"
}

extension Image {
    public init(symbol: ImageSymbol) {
        self.init(systemName: symbol.rawValue)
    }
}
