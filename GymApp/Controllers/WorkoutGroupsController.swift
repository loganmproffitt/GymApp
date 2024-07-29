import Foundation
import RealmSwift

class WorkoutGroupsController: ObservableObject {
    
    static let shared = WorkoutGroupsController()
    
    @Published var viewModels: [ YearMonth: WorkoutListViewModel ] = [:]
    
    
    func loadMonth(yearMonth: YearMonth) {
        viewModels[yearMonth] = WorkoutListViewModel(workouts: WorkoutLoaderService().loadMonth(yearMonth: DateService.getYearMonth(for: Date())), yearMonth: yearMonth)
    }
    
    func loadAllWorkouts() {
        let yearMonth = DateService.getYearMonth(for: Date())
        viewModels[yearMonth] = WorkoutListViewModel(workouts: WorkoutLoaderService().loadAllWorkouts(), yearMonth: yearMonth)
    }
    
    func addWorkout(providedDate: Date? = nil) -> ObjectId {
        let date = providedDate ?? Date()
        let workoutID = getViewModel(for: date).addWorkout(date: date)
        return workoutID
    }
    
    func getViewModel(for date: Date) -> WorkoutListViewModel {
        // Get year and month from date
        let yearMonth = DateService.getYearMonth(for: date)
        
        // Check for existing view model
        if let viewModel = viewModels[yearMonth] {
            return  viewModel
        }
        else {
            // If not found, create a new view model from the given year and month
            let newViewModel = WorkoutListViewModel(workouts: [], yearMonth: yearMonth)
            viewModels[yearMonth] = newViewModel
            return newViewModel
        }
    }
}
