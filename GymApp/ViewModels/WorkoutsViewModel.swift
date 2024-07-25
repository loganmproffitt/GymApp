import Foundation
import SwiftUI

class WorkoutsViewModel: ObservableObject {
    
    @Published var workouts: [WorkoutViewModel] = []
    @Published var yearMonth: YearMonth
    
    init(workouts: [WorkoutViewModel], yearMonth: YearMonth) {
        self.workouts = workouts
        self.yearMonth = yearMonth
    }
    
    func addWorkout(date: Date) -> UUID {
        // Populate new workout
        var workout = Workout.default
        workout.rawDate = date
        workout.date = DateService.getFormattedDate(for: date)
        workout.name = DateService.getWeekday(for: date)
        
        workouts.append(WorkoutViewModel(workout: workout))
        return workout.id
    }
    
    func binding(for workoutID: UUID) -> Binding<WorkoutViewModel> {
        return Binding<WorkoutViewModel>(
            get: {
                self.workouts.first { $0.id == workoutID } ?? WorkoutViewModel(workout: Workout.default)
            },
            set: {
                if let index = self.workouts.firstIndex(where: { $0.id == workoutID }) {
                    self.workouts[index] = $0
                }
            }
        )
    }
}
