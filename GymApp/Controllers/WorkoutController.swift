import Foundation
import SwiftUI

class WorkoutController: ObservableObject {
    
    @Published var workout: WorkoutViewModel
    var viewModel: WorkoutsViewModel
    
    init(workout: WorkoutViewModel, viewModel: WorkoutsViewModel) {
        self.workout = workout
        self.viewModel = viewModel
    }
    
    func addExercise() {
        workout.addExercise(Exercise(name: "", completed: false, notes: "", setCount: "", setCountModified: false, sets: []))
        objectWillChange.send()
    }
    
    func deleteExercise(at index: Int) {
        workout.removeExercise(at: index)
    }
    
    func saveWorkout() {
        print("Save workout called.")
    }
    
}
