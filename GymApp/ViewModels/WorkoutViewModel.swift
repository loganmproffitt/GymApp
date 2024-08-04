import Foundation
import RealmSwift

class WorkoutViewModel: ObservableObject, Identifiable {
    
    @Published private var _name: String
    @Published private var _notes: String
    @Published private var _exercises: List<Exercise>
    @Published private var _isTemplate: Bool
    
    @Published var workout: Workout
    
    init(workout: Workout) {
        self.workout = workout
        self._name = workout.name
        self._notes = workout.notes
        self._exercises = workout.exercises
        self._isTemplate = workout.isTemplate
    }
    
    var id: ObjectId {
        workout.id
    }
    
    var name: String {
        get {
            _name
        }
        set {
            _name = newValue
            RealmService.shared.update {
                self.workout.name = newValue
            }
        }
    }
    
    var notes: String {
        get {
            _notes
        }
        set {
            _notes = newValue
            RealmService.shared.update {
                self.workout.notes = newValue
            }
        }
    }
    
    var isTemplate: Bool {
        get {
            _isTemplate
        }
        set {
            _isTemplate = newValue
            RealmService.shared.update {
                self.workout.isTemplate = newValue
            }
        }
    }
    
    var exercises: List<Exercise> {
        get {
            _exercises
        }
        set {
            _exercises = newValue
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
        // Sync private variable with the updated workout
        _exercises = workout.exercises
    }
    
    // Remove exercise
    func removeExercise(at index: Int) {
        RealmService.shared.update {
            guard index < self.workout.exercises.count else { return }
            self.workout.exercises.remove(at: index)
        }
        // Sync private variable with the updated workout
        _exercises = workout.exercises
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
