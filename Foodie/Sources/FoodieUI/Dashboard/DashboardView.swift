import SwiftUI
import SwiftData
import FoodieModels
import FoodieServices

struct DashboardView: View {
    @Environment(Navigator.self) var navigator: Navigator
    @Environment(\.modelContext) private var modelContext: ModelContext
    @Query private var items: [Food]
    let calorieService = CalorieService()
    let user: User
    
    init(user: User) {
        self.user = user
    }
    
    var body: some View {
        Form {
            Section("Recommended daily calories") {
                if let estimatedDailyCalories {
                    Text(fmt(estimatedDailyCalories))
                } else {
                    Button {
                        navigator.push(.settings)
                    } label: {
                        HStack {
                            Image(symbol: .exclamationMarkTriangle)
                            Text("Missing required information for accurate daily calorie count")
                        }
                    }
                }
            }
            Section("Current daily calories") {
                Text(fmt(currentDailyCalories))
            }
            
            NutrientsProgress(food: items, user: user)
            
            Section("Food") {
                if items.isEmpty {
                    Text("You haven't eaten anything today")
                }
                List {
                    ForEach(items) { item in
                        Button {
                            navigator.push(.foodEditor(item))
                        } label: {
                            HStack {
                                Text(item.name)
                                Spacer()
                                Text(fmt(item.calories))
                                    .foregroundStyle(.black)
                            }
                        }
                    }
                    .onDelete(perform: delete)
                }
            }
        }
        .navigationTitle(today)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    navigator.push(.settings)
                } label: {
                    Image(symbol: .gearshapeFill)
                        .imageScale(.large)
                }
            }
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    navigator.push(.foodEditor(nil))
                } label: {
                    Image(symbol: .plus)
                        .imageScale(.large)
                }
            }
        }
    }
    
    var today: String {
        Date.now.formatted(
            .dateTime
                .year(.defaultDigits)
                .month(.abbreviated)
                .day(.twoDigits))
    }
    
    var currentDailyCalories: Double {
         items.reduce(0) { $0 + $1.calories }
    }
    
    var estimatedDailyCalories: Double? {
        calorieService.estimateDailyCalories(for: user)
    }
    
    func delete(at offsets: IndexSet) {
        guard items.indices.contains(offsets) else { return }
        for index in offsets {
            let model = items[index]
            modelContext.delete(model)
        }
    }
    
    func fmt(_ value: Double) -> String {
        let formattedValue = value.formatted(.number.precision(.fractionLength(2)))
        return "\(formattedValue) cal"
    }
}
