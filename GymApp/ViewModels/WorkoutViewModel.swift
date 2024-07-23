import Foundation
import SwiftUI

class WorkoutViewModel: ObservableObject {
    
    @Published var workouts: [Workout] = []
    @Published var yearMonth: YearMonth
    
    init(workouts: [Workout], yearMonth: YearMonth) {
        self.workouts = workouts
        self.yearMonth = yearMonth
    }
    
    func addWorkout(date: Date) -> UUID {
        // Populate new workout
        var workout = Workout.default
        workout.rawDate = date
        workout.date = DateService.getFormattedDate(for: date)
        workout.name = DateService.getWeekday(for: date)
        
        workouts.append(workout)
        return workout.id
    }
    
    func binding(for workoutID: UUID) -> Binding<Workout> {
        return Binding<Workout>(
            get: {
                self.workouts.first { $0.id == workoutID } ?? Workout.default
            },
            set: {
                if let index = self.workouts.firstIndex(where: { $0.id == workoutID }) {
                    self.workouts[index] = $0
                }
            }
        )
    }
}
