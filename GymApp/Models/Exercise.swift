import Foundation
import RealmSwift

class Exercise: Object, Identifiable {
    @Persisted(primaryKey: true) var id: ObjectId = ObjectId.generate()
    @Persisted var name: String = ""
    @Persisted var completed: Bool = false
    @Persisted var notes: String = ""
    @Persisted var setCountModified: Bool = false
    @Persisted var setCount: String = ""
    @Persisted var sets: List<Set> = List<Set>()

    static var `default`: Exercise {
        return Exercise(name: "", completed: false, notes: "", setCount: "", setCountModified: false, sets: [Set.default])
    }

    // Convenience initializer
    convenience init(name: String, completed: Bool, notes: String, setCount: String, setCountModified: Bool, sets: [Set] = []) {
        self.init()
        self.name = name
        self.completed = completed
        self.notes = notes
        self.setCount = setCount
        self.setCountModified = setCountModified
        self.sets.append(objectsIn: sets)
    }
}
