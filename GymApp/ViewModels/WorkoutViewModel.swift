import Foundation
import RealmSwift

class WorkoutViewModel: ObservableObject {
    
    @Published var workout: Workout
    
    init(workout: Workout) {
        self.workout = workout
    }
    
    var id: ObjectId {
        workout.id
    }
    
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
    
    
    // Date info
    
    // Formatted date
    var formattedDate: String {
        return DateService.getFormattedDate(for: workout.rawDate)
    }
    
    var year: Int {
        return workout.year
    }
    
    var month: Int {
        return workout.month
    }
    
    var yearMonth: YearMonth {
        return YearMonth(year: year, month: month)
    }
    
}
