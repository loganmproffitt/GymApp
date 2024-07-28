import Foundation
import RealmSwift

class Set: Object, Identifiable {
    @Persisted(primaryKey: true) var id: ObjectId = ObjectId.generate()
    @Persisted var weight: String = ""
    @Persisted var reps: String = ""

    static var `default`: Set {
        return Set(weight: "", reps: "")
    }

    convenience init(weight: String, reps: String) {
        self.init()
        self.weight = weight
        self.reps = reps
    }
}
