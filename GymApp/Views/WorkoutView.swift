import SwiftUI

struct WorkoutView: View {
    
    @Binding private var workoutViewModel: WorkoutViewModel
    
    init(workoutViewModel: Binding<WorkoutViewModel>) {
        self._workoutViewModel = workoutViewModel
    }

    var body: some View {
        // Exercise vertical stack
        VStack(spacing: 5) {
            
            // Workout name and date
            HStack {
                TextField(workoutViewModel.name, text: $workoutViewModel.name)
                    .font(.title)
                    .padding(.leading)
                    .onChange(of: workoutViewModel.name) { oldValue, newValue in
                        //workoutViewModel.name = newValue
                    }
                Spacer() // Pushes the TextField to the left
                
                Text(workoutViewModel.formattedDate)
                    .font(.caption)
                    .foregroundColor(.gray)
                    .padding(.trailing)
            }
            .padding(.top) // Add padding at the top
            
            
            // Exercises list
            List {
                Section(header: Text("Exercises").font(.caption).foregroundColor(.gray)) {
                    
                    // List exercises
                    ForEach(workoutViewModel.exercises.indices, id: \.self) { index in
                        ExerciseCardView(
                            exerciseViewModel: ExerciseViewModel(exercise: workoutViewModel.exercises[index]))
                    }
                    .onDelete { indexSet in
                        if let index = indexSet.first {
                            workoutViewModel.removeExercise(at: index)
                        }
                    }
                    
                
                    // New exercise button
                    HStack {
                        Button(action: workoutViewModel.addExercise) {
                            HStack {
                                Image(systemName: "plus.circle.fill")
                            }
                        }
                        Text("Add Exercise")
                    }
                }
            }
            .scrollDismissesKeyboard(.interactively)
        }
    }
}

struct WorkoutDetailView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutsPageView()
    }
}
