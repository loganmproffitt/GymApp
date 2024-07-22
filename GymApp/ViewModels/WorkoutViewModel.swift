import Foundation
import SwiftUI

class WorkoutViewModel: ObservableObject {
    // Create singleton instance of view model
    static let shared = WorkoutViewModel()
    
    @Published var workouts: [Workout] = []
    
    // Function for creating bindings for workout list
    func binding(for workoutID: UUID) -> Binding<Workout> {
        return Binding<Workout>(
            get: {
                self.workouts.first { $0.id == workoutID } ?? Workout.default // Provide a default or handle nil
            },
            set: {
                if let index = self.workouts.firstIndex(where: { $0.id == workoutID }) {
                    self.workouts[index] = $0
                }
            }
        )
    }
    
    
    // Load saved workouts
    init() {
       // workouts = WorkoutDataManager.shared.loadWorkouts()
    }
    
    func saveWorkouts() {
        //WorkoutDataManager.shared.saveWorkouts(workouts)
    }
}
