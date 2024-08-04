import Foundation
import RealmSwift

class WorkoutGroupsController: ObservableObject {
    
    static let shared = WorkoutGroupsController()

    
    @Published var viewModels: [ YearMonth: WorkoutListViewModel ] = [:]
    @Published var keys: [YearMonth] = []
    
    func loadAllMonths() {
        // Get and sort keys
        keys = WorkoutLoaderService().getStoredYearMonths()
        sortKeys()
        
        // Load months
        for yearMonth in keys {
            loadMonth(yearMonth: yearMonth)
        }
    }
    
    func loadMonth(yearMonth: YearMonth) {
        viewModels[yearMonth] = WorkoutListViewModel(workouts: WorkoutLoaderService().loadMonth(yearMonth: yearMonth), yearMonth: yearMonth)
    }
    
    func loadAllWorkouts() {
        let yearMonth = DateService.getYearMonth(for: Date())
        viewModels[yearMonth] = WorkoutListViewModel(workouts: WorkoutLoaderService().loadAllWorkouts(), yearMonth: yearMonth)
    }
    
    func addWorkout(workout: Workout) -> ObjectId {
        let workoutID = getWorkoutListViewModel(for: workout.rawDate).addWorkout(workout: workout)
        
        return workoutID
    }
    
    func getWorkoutListViewModel(for date: Date) -> WorkoutListViewModel {
        // Get year and month from date
        let yearMonth = DateService.getYearMonth(for: date)
        
        // Check for existing view model
        if let viewModel = viewModels[yearMonth] {
            return viewModel
        }
        else {
            // If not found, create a new view model from the given year and month
            let newViewModel = WorkoutListViewModel(workouts: [], yearMonth: yearMonth)
            viewModels[yearMonth] = newViewModel
            
            // Add new key and re-sort
            keys.append(yearMonth)
            sortKeys()
            
            return newViewModel
        }
    }
    
    func removeMonth(for yearMonth: YearMonth) {
        // Remove view model
        viewModels.removeValue(forKey: yearMonth)
        
        // Remove key from key list and sort
        if let index = keys.firstIndex(where: { $0 == yearMonth }) {
            keys.remove(at: index)
            sortKeys()
        }
    }
    
    func sortKeys() {
        keys = keys.sorted(by: {
            if $0.year == $1.year {
                return $0.month > $1.month
            }
            else {
                return $0.year > $1.year
            }
        })
    }
}
