import SwiftUI
import SwiftData
import FoodieModels
import FoodieServices

struct DashboardView: View {
    @Environment(Navigator.self) var navigator: Navigator
    @Environment(\.modelContext) private var modelContext: ModelContext
    @AppStorage(UserDefaultsKey.height.rawValue) var heightCm: Double = 0
    @AppStorage(UserDefaultsKey.weight.rawValue) var weightKg: Double = 0
    @AppStorage(UserDefaultsKey.sex.rawValue) var sex: Int = -1
    @AppStorage(UserDefaultsKey.age.rawValue) var age: Int = 0
    @AppStorage(UserDefaultsKey.activityLevel.rawValue) var activityLevel: Int = -1
    @Query private var items: [Food]
    let calorieService = CalorieService()
    
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
            
            NutrientsProgress(food: items)
            
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
        .navigationBarTitleDisplayMode(.large)
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
        guard let sex = Sex(rawValue: sex) else { return nil }
        guard age > 0 else { return nil }
        guard let level = ActivityLevel(rawValue: activityLevel) else { return nil }

        return calorieService.estimateDailyCalories(
            heightCm: heightCm,
            weightKg: weightKg,
            age: age,
            sex: sex,
            activityLevel: level
        )
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
