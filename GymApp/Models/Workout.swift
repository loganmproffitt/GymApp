import Foundation
import RealmSwift

class Workout: Object, Identifiable {
    @Persisted(primaryKey: true) var id: ObjectId = ObjectId.generate()
    @Persisted var name: String = ""
    @Persisted var rawDate: Date = Date()
    @Persisted var date: String = ""
    @Persisted var notes: String = ""
    @Persisted var exercises: List<Exercise> = List<Exercise>()

    static var `default`: Workout {
        let workout = Workout()
        workout.name = ""
        workout.rawDate = Date()
        workout.date = ""
        workout.notes = ""
        workout.exercises.append(Exercise.default)
        return workout
    }

    // Convenience initializer
    convenience init(name: String, rawDate: Date, date: String, notes: String, exercises: [Exercise] = []) {
        self.init()
        self.name = name
        self.rawDate = rawDate
        self.date = date
        self.notes = notes
        self.exercises.append(objectsIn: exercises)
    }
}
