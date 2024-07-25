import Foundation
import SwiftUI

class WorkoutViewModel: ObservableObject {
    
    @Published private var workout: Workout
    
    init(workout: Workout) {
        self.workout = workout
    }
    
    var id: UUID {
        workout.id
    }
    
    // Get/set name
    var name: String {
        get {
            workout.name
        }
        set {
            workout.name = newValue
        }
    }
    
    // Get/set raw date
    var rawDate: Date {
        get {
            workout.rawDate
        }
        set {
            workout.rawDate = newValue
        }
    }
    
    // Get/set date
    var date: String {
        get {
            workout.date
        }
        set {
            workout.date = newValue
        }
    }
    
    // Get/set notes
    var notes: String {
        get {
            workout.notes
        }
        set {
            workout.notes = newValue
        }
    }
    
    // Get/set exercises
    var exercises: [Exercise] {
        get {
            workout.exercises
        }
        set {
            workout.exercises = newValue
        }
    }
    
    // Add exercise
    func addExercise(_ exercise: Exercise) {
        workout.exercises.append(exercise)
    }
    
    // Remove exercise
    func removeExercise(at index: Int) {
        guard index < workout.exercises.count else { return }
        workout.exercises.remove(at: index)
    }

}
