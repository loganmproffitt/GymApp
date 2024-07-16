import Foundation
import SwiftUI

class YearViewModel: ObservableObject {
    // Create singleton instance of view model
    static let shared = YearViewModel()
    
    @Published var years: [Year] = []
    
    // Function for creating bindings for a list of years
    func binding(for yearID: UUID) -> Binding<Year> {
        return Binding<Year>(
            get: {
                self.years.first { $0.id == yearID } ?? Year.default // Provide a default or handle nil
            },
            set: {
                if let index = self.years.firstIndex(where: { $0.id == yearID }) {
                    self.years[index] = $0
                }
            }
        )
    }
}
