import SwiftUI

enum Route {
    case splash
    case setup
    case dashboard
    case settings
    case foodEditor
}

@Observable
class Navigator {
    public var path: NavigationPath = NavigationPath([Route.dashboard])
    
    init() {}
    
    func push(_ route: Route) {
        path.append(route)
        print(path)
    }
    
    func pop() {
        path.removeLast()
    }
}
