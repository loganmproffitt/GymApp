import Foundation
import RealmSwift

class WorkoutViewModel: ObservableObject {
    
    @Published private var workout: Workout
    
    init(workout: Workout) {
        self.workout = workout
    }
    
    var id: ObjectId {
        workout.id
    }
    
    // Get/set name
    var name: String {
        get {
            workout.name
        }
        set {
            RealmService.shared.update {
                self.workout.name = newValue
            }
        }
    }
    
    // Get/set raw date
    var rawDate: Date {
        get {
            workout.rawDate
        }
        set {
            RealmService.shared.update {
                self.workout.rawDate = newValue
            }
        }
    }
    
    // Get/set date
    var date: String {
        get {
            workout.date
        }
        set {
            RealmService.shared.update {
                self.workout.date = newValue
            }
        }
    }
    
    // Get/set notes
    var notes: String {
        get {
            workout.notes
        }
        set {
            RealmService.shared.update {
                self.workout.notes = newValue
            }
        }
    }
    
    // Get/set exercises
    var exercises: List<Exercise> {
        get {
            workout.exercises
        }
        set {
            RealmService.shared.update {
                self.workout.exercises.removeAll()
                self.workout.exercises.append(objectsIn: newValue)
            }
        }
    }
    
    // Add exercise
    func addExercise(_ exercise: Exercise) {
        RealmService.shared.update {
            self.workout.exercises.append(exercise)
        }
    }
    
    // Remove exercise
    func removeExercise(at index: Int) {
        RealmService.shared.update {
            guard index < self.workout.exercises.count else { return }
            self.workout.exercises.remove(at: index)
        }
    }
}
