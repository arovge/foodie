import SwiftUI
import SwiftData
import FoodieModels
import FoodieServices

@MainActor
public struct RootView: View {
    @State var navigator = Navigator()
    @State var viewModel = RootViewModel()
    
    public init() {}
    
    public var body: some View {
        NavigationStack(path: $navigator.path) {
            EmptyView()
                .navigationDestination(for: Route.self) { route in
                    switch route {
                    case .splash:
                        ProgressView()
                    case let .dashboard(user):
                        DashboardView(user: user)
                            .navigationBarBackButtonHidden()
                            .environment(navigator)
                    case .settings:
                        SettingsView()
                            .environment(navigator)
                    case .setup:
                        SetupView()
                            .navigationBarBackButtonHidden()
                            .environment(navigator)
                    case .foodEditor(let food):
                        FoodEditor(existingFood: food)
                            .environment(navigator)
                    }
                }
                .onAppear {
                    viewModel.handleAppear(navigator)
                }
        }
        .modelContainer(for: Food.self)
    }
}
