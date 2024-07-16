import Foundation
import SwiftUI

class DayViewModel: ObservableObject {
    // Create singleton instance of view model
    static let shared = DayViewModel()
    
    @Published var days: [Day] = []
    
    // Function for creating bindings for a list of years
    func binding(for dayID: UUID) -> Binding<Day> {
        return Binding<Day>(
            get: {
                self.days.first { $0.id == dayID } ?? Day.default // Provide a default or handle nil
            },
            set: {
                if let index = self.days.firstIndex(where: { $0.id == dayID }) {
                    self.days[index] = $0
                }
            }
        )
    }
}
