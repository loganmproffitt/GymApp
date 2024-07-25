import Foundation
import SwiftUI

class WorkoutController: ObservableObject {
    
    @Published var workout: Workout
    var viewModel: WorkoutsViewModel
    
    init(workout: Workout, viewModel: WorkoutsViewModel) {
        self.workout = workout
        self.viewModel = viewModel
    }
    
    func addExercise() {
        workout.exercises.append(Exercise(name: "", completed: false, notes: "", setCount: "", setCountModified: false, sets: []))
        //objectWillChange.send()
    }
    
    func deleteExercise(at offsets: IndexSet) {
        workout.exercises.remove(atOffsets: offsets)
    }
    
    func saveWorkout() {
        print("Save workout called.")
    }
    
    
    /*
    func modifySetCount(for exercise: Binding<Exercise>)
    {
        // If blank, set modified to false
        if (setsValue == "" || setsValue == "Sets")
        {
            exercise.wrappedValue.setCountModified = false
        }
        else    // Else, set modified to true and update setCount
        {
            exercise.setCountModified = true
            exercise.setCount = setsValue
            //viewModel.saveWorkouts()
        }
    }
    
    func updateSetCount()
    {
        // If sets not modified, set to number of sets in list
        if (exercise.setCountModified == false)
        {
            setsValue = String(exercise.sets.count)
        }
    }
    
    
    func addSet() {
        exercise.sets.append(Set.default)
        updateSetCount()
        //viewModel.saveWorkouts()
    }
    
    func deleteSet(at offsets: IndexSet) {
        exercise.sets.remove(atOffsets: offsets)
        updateSetCount()
        //viewModel.saveWorkouts()
    }
    */
}
