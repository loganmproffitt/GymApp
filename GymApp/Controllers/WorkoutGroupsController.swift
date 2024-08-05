import Foundation
import RealmSwift

class WorkoutGroupsController: ObservableObject {
    
    static let shared = WorkoutGroupsController()
    
    // Store a blank workout for adding. Allows resetting after adding so that a different workout is created each time
    @Published var newWorkout = WorkoutViewModel(workout: Workout.default)
    
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
    
    // Takes a workout view model and adds it to the correct workout list
    func addWorkout(workout: WorkoutViewModel) -> ObjectId {
        // Add workout view model to the correct workout list and get its ID
        let workoutID = getWorkoutListViewModel(for: workout.rawDate).addWorkout(workoutViewModel: workout)
        return workoutID
    }
    
    // Gets the workout list for a given month and year
    func getWorkoutListViewModel(for date: Date) -> WorkoutListViewModel {
        // Get year and month from date
        let yearMonth = DateService.getYearMonth(for: date)
        
        // Check for existing view model
        if let viewModel = viewModels[yearMonth] {
            return viewModel
        }
        else {
            // If not found, create a new workout list for the given year and month
            let newViewModel = WorkoutListViewModel(workouts: [], yearMonth: yearMonth)
            // Add the new list to the dictionary
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
