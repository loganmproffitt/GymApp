import Foundation

struct Day: Identifiable, Codable {
    var id = UUID()
    var weekday: String
    var date: String
    var workouts: [Workout]
    
    static var `default`: Day {
        Day(weekday: "", date: "", workouts: [])
    }
    
    init(weekday: String, date: String, workouts: [Workout])
    {
        self.weekday = weekday
        self.date = date
        self.workouts = workouts
    }
}

