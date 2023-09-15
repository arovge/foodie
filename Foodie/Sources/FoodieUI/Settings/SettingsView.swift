import SwiftUI
import SwiftData
import FoodieModels
import FoodieServices

struct SettingsView: View {
    @Environment(Navigator.self) var navigator: Navigator
    
    // TODO: Move this to `Measurement` ex: `Measurement(value: 1230, unit: UnitLength.meters)`
    // TOOD: Look at creating an @AppStorage wrapper that takes a `UserDefaultsKey` enum
    @AppStorage(UserDefaultsKey.height.rawValue) var height: Double = 0
    @AppStorage(UserDefaultsKey.weight.rawValue) var weight: Double = 0
    @AppStorage(UserDefaultsKey.age.rawValue) var age: Int = 0
    @AppStorage(UserDefaultsKey.sex.rawValue) var sex: Int = -1
    @AppStorage(UserDefaultsKey.activityLevel.rawValue) var activityLevel: Int = -1
    
    var body: some View {
        Form {
            Section("Height (cm)") {
                TextField("Height (cm)", text: $height.str())
            }
            Section("Weight (kg)") {
                TextField("Weight (kg)", text: $weight.str())
            }
            Section("Age (years)") {
                TextField("Age (years)", text: $age.str())
            }
            Section("Sex") {
                Picker("Sex", selection: $sex) {
                    ForEach(Sex.allCases) {
                        Text($0.description)
                            .tag($0.rawValue)
                    }
                }
                if sex == Sex.other.rawValue {
                    Text("Other will use the same values as 'Female' for calculating your daily recommended calories")
                }
            }
            Section("Activity Level") {
                Picker("Activity Level", selection: $activityLevel) {
                    ForEach(ActivityLevel.allCases) {
                        Text($0.label)
                            .tag($0.rawValue)
                    }
                }
                if let level = ActivityLevel(rawValue: activityLevel) {
                    Text(level.description)
                }
            }
        }
        .navigationTitle("Settings")
        .navigationBarTitleDisplayMode(.large)
    }
}
