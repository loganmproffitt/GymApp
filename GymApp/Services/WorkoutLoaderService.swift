import Foundation
import RealmSwift

class WorkoutLoaderService {
    
    // Loads all workouts
    func loadAllWorkouts() -> [WorkoutViewModel] {
        let realm = RealmService.shared.getRealm()
        // Get workouts
        let workouts = Array(realm.objects(Workout.self))
        
        return getWorkoutViewModels(workouts: workouts)
    }
    
    // Loads the workouts from a specific year and month
    func loadMonth(yearMonth: YearMonth) -> [WorkoutViewModel] {
        let realm = RealmService.shared.getRealm()
        let workouts = Array(realm.objects(Workout.self).filter("year == %@ AND month == %@", yearMonth.year, yearMonth.month))
        return getWorkoutViewModels(workouts: workouts)
    }
    
    
    // Helper to wrap each workout from an array in a WorkoutViewModel
    func getWorkoutViewModels(workouts: Array<Workout>) -> [WorkoutViewModel] {
        var viewModels: [WorkoutViewModel] = []
        for workout in workouts {
            viewModels.append(WorkoutViewModel(workout: workout))
        }
        return viewModels
    }
}
