import Foundation

struct Workout: Identifiable, Codable {
    var id = UUID()
    var name: String
    var rawDate: Date
    var date: String
    var notes: String
    var exercises: [Exercise]
    
    static var `default`: Workout {
        Workout(name: "", rawDate: Date(), date: "", notes: "", exercises: [Exercise.default])
    }
}
