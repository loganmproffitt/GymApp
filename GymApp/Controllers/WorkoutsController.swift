import Foundation

class WorkoutsController: ObservableObject {
    
    @Published var workouts: [WorkoutViewModel]
    
    init(workouts: [WorkoutViewModel]) {
        self.workouts = workouts
    }
}
