import Foundation

class WorkoutListController: ObservableObject {
    
    static let shared = WorkoutListController()
    
    @Published var viewModels: [ YearMonth: WorkoutViewModel ] = [:]
    
    func addWorkout(providedDate: Date? = nil) -> UUID {
        let date = providedDate ?? Date()
        let workoutID = getViewModel(for: date).addWorkout(date: date)
        return workoutID
    }
    
    func getViewModel(for date: Date) -> WorkoutViewModel {
        // Get year and month from date
        let yearMonth = DateService.getYearMonth(for: date)
        
        // Check for existing view model
        if let viewModel = viewModels[yearMonth] {
            return viewModel
        }
        else {
            // If not found, create a new view model from the given year and month
            let newViewModel = WorkoutViewModel(workouts: [], yearMonth: yearMonth)
            viewModels[yearMonth] = newViewModel
            return newViewModel
        }
    }
}
