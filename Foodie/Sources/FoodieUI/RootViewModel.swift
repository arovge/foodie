import SwiftUI
import FoodieServices
import FoodieModels
import Foundation

@MainActor
class RootViewModel: ObservableObject {
    let userService = UserService()
    
    func handleAppear(_ navigator: Navigator) {
        if let user = userService.getExistingUser() {
            navigator.push(.dashboard(user))
        } else {
            navigator.push(.setup)
        }
    }
}
