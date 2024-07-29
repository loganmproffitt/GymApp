import SwiftUI

struct WorkoutView: View {
    
    @ObservedObject private var workoutController: WorkoutController
    
    init(controller: WorkoutController) {
        self.workoutController = controller

    }
    
    @State private var newExerciseName: String = ""
    @FocusState private var isTextFieldFocused: Bool

    var body: some View {
        // Exercise vertical stack
        VStack(spacing: 5) {
            
            // Workout name and date
            HStack {
                TextField(workoutController.workout.name, text: $workoutController.workout.name)//, onCommit: viewModel.saveWorkouts)
                    .font(.title)
                    .padding(.leading)
                    .onDisappear {
                        //viewModel.saveWorkouts()
                    }
                    .onChange(of: isTextFieldFocused) { oldValue, isFocused in
                        if !isFocused {
                            //viewModel.saveWorkouts()
                        }
                    }
                Spacer() // Pushes the TextField to the left
                
                Text(workoutController.workout.date)
                    .font(.caption)
                    .foregroundColor(.gray)
                    .padding(.trailing)
            }
            .padding(.top) // Add padding at the top
            
            
            // Exercises list
            List {
                Section(header: Text("Exercises").font(.caption).foregroundColor(.gray)) {
                    
                    // List exercises
                    ForEach(workoutController.workout.exercises.indices, id: \.self) { index in
                        ExerciseCardView(
                            exerciseViewModel: ExerciseViewModel(exercise: workoutController.workout.exercises[index]))
                    }
                    .onDelete { indexSet in
                        if let index = indexSet.first {
                            workoutController.deleteExercise(at: index)
                        }
                    }
                    
                
                    // New exercise button
                    HStack {
                        Button(action: workoutController.addExercise) {
                            HStack {
                                Image(systemName: "plus.circle.fill")
                            }
                        }
                        Text("Add Exercise")
                    }
                }
                
                
            }
            .scrollDismissesKeyboard(.interactively)
            .onChange(of: isTextFieldFocused) { oldValue, newValue in
                if !newValue {
                    //viewModel.saveWorkouts()
                }
            }
        }
    }
    
    private func deleteExercise(at index: Int) {
        workoutController.deleteExercise(at: index)
    }
}

struct WorkoutDetailView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutsPageView()
    }
}
