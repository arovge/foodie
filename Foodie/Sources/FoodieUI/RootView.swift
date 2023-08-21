import SwiftUI
import SwiftData
import FoodieModels


public struct RootView: View {
    @State var navigator = Navigator()
    
    public init() {}
    
    public var body: some View {
        @Bindable var nav = navigator
        NavigationStack(path: $nav.path) {
            ProgressView()
                .navigationDestination(for: Route.self) { route in
                    switch route {
                    case .dashboard:
                        DashboardView()
                            .navigationBarBackButtonHidden()
                            .environment(navigator)
                    case .settings:
                        SettingsView()
                            .environment(navigator)
                    case .setup:
                        SetupView()
                            .environment(navigator)
                    case .splash:
                        ProgressView()
                    case .foodEditor:
                        FoodEditor()
                            .environment(navigator)
                    }
                }
        }
    }
}
