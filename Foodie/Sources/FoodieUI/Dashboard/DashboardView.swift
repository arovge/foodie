import SwiftUI
import SwiftData
import FoodieModels

struct DashboardView: View {
    @Environment(Navigator.self) var navigator: Navigator
    @Environment(\.modelContext) private var modelContext: ModelContext
    @Query private var items: [Food]
    
    var body: some View {
        Form {
            if items.isEmpty {
                Text("You haven't eaten anything today")
            }
            List(items) { item in
                Text(item.name)
            }
        }
        .navigationTitle(today)
        .navigationBarTitleDisplayMode(.large)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    navigator.push(.settings)
                } label: {
                    Image(systemName: "gearshape.fill")
                        .imageScale(.large)
                }
            }
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    navigator.push(.foodEditor)
                } label: {
                    Image(systemName: "plus")
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
}
