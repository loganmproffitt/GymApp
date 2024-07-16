import Foundation

class WorkoutService {
    static let shared = WorkoutService()
    
    func addWorkout(viewModel: WorkoutViewModel) -> UUID {
        // Get date
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yy"
        let dateString = formatter.string(from: date)
        
        // Get weekday
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        let weekday = dateFormatter.string(from: date)
        let newWorkout = Workout(name: weekday, date: dateString, notes: "", exercises: [Exercise.default])
        viewModel.workouts.append(newWorkout)
        viewModel.saveWorkouts()
        
        return newWorkout.id
    }
    
    func deleteWorkout(workout: Workout, from viewModel: WorkoutViewModel) {
        if let index = viewModel.workouts.firstIndex(where: { $0.id == workout.id }) {
            viewModel.workouts.remove(at: index)
            viewModel.saveWorkouts()
        }
    }
}
