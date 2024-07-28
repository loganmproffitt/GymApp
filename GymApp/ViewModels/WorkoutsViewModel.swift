import Foundation
import SwiftUI
import RealmSwift

class WorkoutsViewModel: ObservableObject {
    
    @Published var workouts: [WorkoutViewModel] = []
    @Published var yearMonth: YearMonth
    
    init(workouts: [WorkoutViewModel], yearMonth: YearMonth) {
        self.workouts = workouts
        self.yearMonth = yearMonth
    }
    
    func addWorkout(date: Date) -> ObjectId {

        // Create a new workout
        let workout = Workout()
        workout.rawDate = date
        workout.date = DateService.getFormattedDate(for: date)
        workout.name = DateService.getWeekday(for: date)
        
        // Add workout to realm
        RealmService.shared.add(workout)

        // Create and append the WorkoutViewModel
        let workoutViewModel = WorkoutViewModel(workout: workout)
        workouts.append(workoutViewModel)

        return workout.id
    }
    
    func binding(for workoutID: ObjectId) -> Binding<WorkoutViewModel> {
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
