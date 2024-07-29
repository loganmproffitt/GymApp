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

    static var `default`: Workout {
        let workout = Workout()
        workout.name = ""
        workout.rawDate = Date()
        workout.notes = ""
        workout.exercises.append(Exercise.default)
        workout.setDateValues(from: Date())
        
        return workout
    }

    // Convenience initializer
    convenience init(name: String, rawDate: Date, notes: String, exercises: [Exercise] = []) {
        self.init()
        self.name = name
        self.rawDate = rawDate
        self.notes = notes
        self.exercises.append(objectsIn: exercises)
        self.setDateValues(from: rawDate)
    }
    
    private func setDateValues(from date: Date) {
        year = Calendar.current.component(.year, from: date)
        month = Calendar.current.component(.month, from: date)
        day = Calendar.current.component(.day, from: date)
    }
    
}
