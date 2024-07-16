import Foundation
import SwiftUI

class MonthViewModel: ObservableObject {
    // Create singleton instance of view model
    static let shared = MonthViewModel()
    
    @Published var months: [Month] = []
    
    // Function for creating bindings for a list of years
    func binding(for monthID: UUID) -> Binding<Month> {
        return Binding<Month>(
            get: {
                self.months.first { $0.id == monthID } ?? Month.default // Provide a default or handle nil
            },
            set: {
                if let index = self.months.firstIndex(where: { $0.id == monthID }) {
                    self.months[index] = $0
                }
            }
        )
    }
}
