import Foundation
import SwiftUI

class WorkoutController: ObservableObject {
    
    @Binding var workout: Workout
    
    init(workout: Binding<Workout>) {
        self._workout = workout
    }
    
    func addExercise() {
        workout.exercises.append(Exercise(name: "", completed: false, notes: "", setCount: "", setCountModified: false, sets: []))
        objectWillChange.send()
    }
    
    func deleteExercise(at offsets: IndexSet) {
        workout.exercises.remove(atOffsets: offsets)
    }
    
}
