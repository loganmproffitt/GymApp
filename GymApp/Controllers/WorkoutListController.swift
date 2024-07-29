import Foundation

class WorkoutListController: ObservableObject {
    
    @Published var workouts: [WorkoutViewModel]
    
    init(workouts: [WorkoutViewModel]) {
        self.workouts = workouts
    }
}
