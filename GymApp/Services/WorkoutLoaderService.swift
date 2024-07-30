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
    
    func getYearMonthPairs() -> [YearMonth] {
        let realm = RealmService.shared.getRealm()
        let workouts = realm.objects(Workout.self)
        print(workouts)
        
        var yearMonthSet = Swift.Set<YearMonth>()
        for workout in workouts {
            yearMonthSet.insert(YearMonth(year: workout.year, month: workout.month))
        }
        
        // Convert the set to an array and sort it
        let sortedPairs = yearMonthSet.sorted {
            if $0.year == $1.year {
                return $0.month > $1.month
            } else {
                return $0.year > $1.year
            }
        }

        return sortedPairs
    }
}
