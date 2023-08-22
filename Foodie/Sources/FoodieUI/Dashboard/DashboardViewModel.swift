import SwiftUI
import FoodieServices

@Observable
class DashboardViewModel {
    let calorieService = CalorieService()
    let userDefaultsService = UserDefaultsService()
}
