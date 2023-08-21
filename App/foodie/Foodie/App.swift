import SwiftUI
import SwiftData
import FoodieUI
import FoodieModels

@main
struct FoodieApp: App {
    var body: some Scene {
        WindowGroup {
            RootView()
        }
        .modelContainer(for: Food.self)
    }
}
