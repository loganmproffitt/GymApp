import Foundation

struct Workout: Identifiable, Codable {
    var id = UUID()
    var name: String
    var date: String
    var notes: String
    var exercises: [Exercise]
    
    static var `default`: Workout {
        Workout(name: "", date: "", notes: "", exercises: [Exercise.default])
    }
}
/*
extension Workout {
    static let sampleData: [Workout] =
    [
        Workout(date: "January 1st", notes: "",
                exercises: [Exercise(name: "Bench Press", completed: false, notes: "sample notes", sets: [Set(weight: "165", reps: "10"), Set(weight: "185", reps: "4")]),
                            Exercise(name: "Pushdowns", completed: false, notes: "sample notes", sets: [Set(weight: "110", reps: "12"), Set(weight: "120", reps: "10")])
                           ])
    ]
}*/
