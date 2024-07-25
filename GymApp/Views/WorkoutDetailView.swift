import SwiftUI

struct WorkoutDetailView: View {
    
    @EnvironmentObject var viewModel: WorkoutViewModel
    @Binding var workout: Workout
    
    @StateObject private var controller: WorkoutController
    
    init(workout: Binding<Workout>) {
        self._workout = workout
        self._controller = StateObject(wrappedValue: WorkoutController(workout: workout))
    }
    
    @State private var newExerciseName: String = ""
    @FocusState private var isTextFieldFocused: Bool

    var body: some View {
        // Exercise vertical stack
        VStack(spacing: 5) {
            
            // Workout name and date
            HStack {
                TextField(workout.name, text: $workout.name)//, onCommit: viewModel.saveWorkouts)
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
                
                Text(workout.date)
                    .font(.caption)
                    .foregroundColor(.gray)
                    .padding(.trailing)
            }
            .padding(.top) // Add padding at the top
            
            
            // Exercises list
            List {
                Section(header: Text("Exercises").font(.caption).foregroundColor(.gray)) {
                    
                    // List exercises
                    ForEach($workout.exercises.indices, id: \.self) { index in
                        ExerciseCardView(exercise: $workout.exercises[index])
                    }
                    .onDelete(perform: deleteExercise)
                    
                
                    // New exercise button
                    HStack {
                        Button(action: controller.addExercise) {
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
    
    private func deleteExercise(at offsets: IndexSet) {
        controller.deleteExercise(at: offsets)
    }
}

struct WorkoutDetailView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutsPageView()
    }
}
