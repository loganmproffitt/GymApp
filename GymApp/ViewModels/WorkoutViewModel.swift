import Foundation
import RealmSwift

class WorkoutViewModel: ObservableObject, Identifiable {
    
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
            print("Updated name to \(workout.name)")
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
    func addExercise() {
        RealmService.shared.update {
            self.workout.exercises.append(Exercise.default)
        }
        objectWillChange.send()
    }
    
    // Remove exercise
    func removeExercise(at index: Int) {
        RealmService.shared.update {
            guard index < self.workout.exercises.count else { return }
            self.workout.exercises.remove(at: index)
        }
    }
    
    
    // Date info
    
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
    
    var year: Int {
        workout.year
    }
    
    var month: Int {
        workout.month
    }
    
    var day: Int {
        workout.day
    }
    
    // Formatted date
    var formattedDate: String {
        return DateService.getFormattedDate(for: workout.rawDate)
    }
    
    // Get YearMonth structure
    var yearMonth: YearMonth {
        YearMonth(year: year, month: month)
    }
    
    // Get the weekday as a string
    var weekDay: String {
        DateService.getWeekday(for: workout.rawDate)
    }

}
