import Foundation

struct Day: Identifiable, Codable {
    var id = UUID()
    var weekday: String
    var date: String
    var dayNumber: Int
    var workouts: [Workout]
    
    static var `default`: Day {
        Day(weekday: "", date: "", dayNumber: 1, workouts: [])
    }
    
    init(weekday: String, date: String, dayNumber: Int, workouts: [Workout])
    {
        self.weekday = weekday
        self.date = date
        self.dayNumber = dayNumber
        self.workouts = workouts
    }
    
    mutating func addWorkout(for components: DateComponents) -> UUID {
        var workout = Workout.default
        workout.date = date
        workout.name = weekday
        workouts.append(workout)
        return workout.id
    }
}

