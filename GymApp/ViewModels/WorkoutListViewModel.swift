import Foundation
import SwiftUI
import RealmSwift

class WorkoutListViewModel: ObservableObject {
    
    @Published var workouts: [WorkoutViewModel] = []
    @Published var yearMonth: YearMonth
    
    init(workouts: [WorkoutViewModel] = [], yearMonth: YearMonth = YearMonth(year: 2024, month: 1)) {
        self.workouts = workouts
        self.yearMonth = yearMonth
        
        // Sort loaded workouts
        sortWorkouts()
    }
    
    private func loadWorkouts() {
        let realm = try! Realm()
        let results = realm.objects(Workout.self).filter("yearMonth == %@", yearMonth)
        self.workouts = results.map { WorkoutViewModel(workout: $0) }
    }
    
    // Sorts workouts in descending order by day
    func sortWorkouts() {
        let sortedWorkouts = workouts.sorted(by: { $0.day > $1.day })
        workouts = sortedWorkouts
    }
    
    func addWorkout(date: Date) -> ObjectId {

        // Create a new workout
        let workout = Workout(name: DateService.getWeekday(for: date), rawDate: date, notes: "", exercises: [])
        
        // Add workout to realm
        RealmService.shared.add(workout)

        // Create and append the WorkoutViewModel
        let workoutViewModel = WorkoutViewModel(workout: workout)
        workouts.append(workoutViewModel)
        
        // Re-sort workouts
        sortWorkouts()
        
        objectWillChange.send()

        return workout.id
    }
    
    func removeWorkout(at index: Int) {
        guard index < self.workouts.count else { return }
        let workoutViewModel = self.workouts[index]
        
        // Remove from Realm
        RealmService.shared.delete(workoutViewModel.workout)
        
        // Remove from local list
        self.workouts.remove(at: index)
        
        // Re-sort workouts
        sortWorkouts()
        
        // Check if empty
        if workouts.isEmpty {
            // If empty, remove month from groups
            WorkoutGroupsController.shared.removeMonth(for: yearMonth)
        }
    }
    
    func binding(for workoutID: ObjectId) -> Binding<WorkoutViewModel> {
        return Binding<WorkoutViewModel>(
            get: {
                self.workouts.first { $0.id == workoutID } ?? WorkoutViewModel(workout: Workout.default)
            },
            set: {
                if let index = self.workouts.firstIndex(where: { $0.id == workoutID }) {
                    self.workouts[index] = $0
                }
            }
        )
    }
}
