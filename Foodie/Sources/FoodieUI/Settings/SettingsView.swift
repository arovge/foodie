import SwiftUI
import SwiftData

struct SettingsView: View {
    @Environment(Navigator.self) var navigator: Navigator
    @AppStorage("userHeight") var userHeight: Double = 0
    @AppStorage("userWeight") var userWeight: Double = 0
    
    var body: some View {
        Form {
            VStack(alignment: .leading) {
                LabeledContent("Height (cm)") {
                    TextField("Height (cm)", text: height)
                }
                LabeledContent("Weight (kg)") {
                    TextField("Weight", text: weight)
                }
                
            }
        }
        .navigationTitle("Settings")
        .navigationBarTitleDisplayMode(.large)
    }
    
    var height: Binding<String> {
        .init(get: {
            if userHeight == 0 { return "" }
            return userHeight.description
        }, set: {
            userHeight = Double($0) ?? 0
        })
    }
    
    var weight: Binding<String> {
        .init(get: {
            if userWeight == 0 { return "" }
            return userWeight.description
        }, set: {
            userWeight = Double($0) ?? 0
        })
    }
}
