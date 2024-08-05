import Foundation
import RealmSwift

class Workout: Object, Identifiable {
    
    @Persisted(primaryKey: true) var id: ObjectId = ObjectId.generate()
    
    // Main workout info
    @Persisted var name: String = ""
    @Persisted var rawDate: Date = Date()
    @Persisted var notes: String = ""
    @Persisted var exercises: List<Exercise> = List<Exercise>()
    
    // Year and month fields to speed up searches
    @Persisted var year: Int = 0
    @Persisted var month: Int = 0
    @Persisted var day: Int = 0
    
    // Template info
    @Persisted var isTemplate: Bool = false

    static var `default`: Workout {
        let workout = Workout()
        workout.name = ""
        workout.notes = ""
        workout.exercises.append(Exercise.default)
        workout.setDateValues(from: Date())
        workout.isTemplate = false
        
        return workout
    }
    
    static var `template`: Workout {
        let workout = Workout()
        workout.name = "New Template"
        workout.notes = ""
        workout.exercises.append(Exercise.default)
        workout.rawDate = Date()
        workout.month = 0
        workout.day = 0
        workout.year = 0
        workout.isTemplate = true
        
        return workout
    }

    convenience init(name: String, rawDate: Date, notes: String, isTemplate: Bool, exercises: [Exercise] = []) {
        self.init()
        self.name = name
        self.notes = notes
        self.exercises.append(objectsIn: exercises)
        self.isTemplate = isTemplate
        
        if !isTemplate {
            self.setDateValues(from: rawDate)
        }
        else {
            self.rawDate = Date()
            self.month = 0
            self.day = 0
            self.year = 0
        }
    }
    
    convenience init(rawDate: Date) {
        self.init()
        self.name = DateService.getWeekday(for: rawDate)
        self.notes = ""
        self.exercises = List<Exercise>()
        self.isTemplate = false
        self.setDateValues(from: rawDate)
    }
    
    func setDateValues(from date: Date) {
        let calendar = Calendar.current
        self.rawDate = date
        self.year = calendar.component(.year, from: date)
        self.month = calendar.component(.month, from: date)
        self.day = calendar.component(.day, from: date)
    }
    
}
