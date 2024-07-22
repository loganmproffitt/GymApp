import Foundation

class WorkoutService {
    static let shared = WorkoutService()
    
    func addWorkout(viewModel: YearViewModel) -> UUID {
        
        // Get date information
        let date = Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day, .month, .year], from: date)

        // Check whether year has been created
        if viewModel.years.firstIndex(where: { $0.year == components.year}) == nil {
            // Create and add year to view model
            let newYear = Year.default
            viewModel.years.append(newYear)
        }
        
        // Get year
        let yearIndex = viewModel.years.firstIndex(where: { $0.year == components.year})
        
        // Add workout for the current date and get the resultin workout ID
        let workoutID = viewModel.years[yearIndex!].addWorkout(for: components)
        
        return workoutID
    }
    
    func deleteWorkout(workout: Workout, from viewModel: WorkoutViewModel) {
        if let index = viewModel.workouts.firstIndex(where: { $0.id == workout.id }) {
            viewModel.workouts.remove(at: index)
            //viewModel.saveWorkouts()
        }
    }
}
