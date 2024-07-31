import SwiftUI

struct WorkoutView: View {
    
    @EnvironmentObject var workoutViewModel: WorkoutViewModel

    var body: some View {
        
        // Exercise vertical stack
        VStack(spacing: -5) {
            
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
                            withAnimation {
                                workoutViewModel.removeExercise(at: index)
                            }
                        }
                    }
                    
                    /*
                     // New exercise button
                     HStack {
                     Button(action: {
                     withAnimation {
                     workoutViewModel.addExercise()
                     }
                     }) {
                     HStack {
                     Image(systemName: "plus.circle.fill")
                     }
                     }
                     Text("Add Exercise")
                     }*/
                    
                    
                }
            }
            .scrollDismissesKeyboard(.interactively)
            
            Spacer()
            
            // Add exercise button
            HStack {
                Spacer()
                Button(action: {
                    withAnimation {
                        workoutViewModel.addExercise()
                    }
                }) {
                    Image(systemName: "plus.circle.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 48, height: 48)
                        .foregroundColor(.blue)
                        .padding()
                }
                .padding()
            }
        }
    }
}

struct WorkoutDetailView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutsPageView()
    }
}
