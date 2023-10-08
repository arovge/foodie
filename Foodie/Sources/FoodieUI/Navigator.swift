import SwiftUI
import FoodieModels

enum Route: Hashable {
    case splash
    case setup
    case dashboard(User)
    case settings
    case foodEditor(Food?)
}

@Observable
class Navigator {
    public var path = NavigationPath([Route.splash])
    
    init() {}
    
    func push(_ route: Route) {
        path.append(route)
    }
    
    func pop() {
        // TODO: Maybe have the empty case be dashboard or something
        // instead of Navigator needing to ensure there's always one route here
        guard path.count > 1 else { return }
        path.removeLast()
    }
    
    func replaceAll(_ route: Route) {
        path = NavigationPath([route])
    }
}
