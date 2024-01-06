//
//  WorkoutDetailView.swift
//  GymApp
//
//  Created by Logan Proffitt on 1/2/24.
//

import SwiftUI

struct WorkoutDetailView: View {
    @Binding var workout: Workout
    @State private var newExerciseName: String = ""
    @ObservedObject var viewModel = WorkoutViewModel.shared
    @FocusState private var isTextFieldFocused: Bool

    var body: some View {
        // Exercise vertical stack
        VStack(spacing: 5) {
            
            // Workout title
            HStack {
                TextField(workout.date, text: $workout.date, onCommit: viewModel.saveWorkouts)
                    .font(.title) // Make the font larger to resemble a title
                    .bold()
                    .padding(.leading) // Add padding to align with the leading edge
                    .onDisappear {
                        viewModel.saveWorkouts()
                    }
                    .onChange(of: isTextFieldFocused) { oldValue, isFocused in
                        if !isFocused {
                            viewModel.saveWorkouts()
                        }
                    }
                Spacer() // Pushes the TextField to the left
            }
            .padding(.top) // Add padding at the top
            
            // List for exercises
            List {
                Section(header: Text("Exercises").font(.caption).foregroundColor(.gray)) {
                    ForEach($workout.exercises.indices, id: \.self) { index in
                        ExerciseDetailView(exercise: $workout.exercises[index])
                    }
                    .onDelete(perform: deleteExercise)
                    
                    // New exercise button
                    HStack {
                        Text("New Exercise")
                        Button(action: addExercise) {
                            HStack {
                                Image(systemName: "plus.circle.fill")
                            }
                        }
                    }
                }
            }
            .scrollDismissesKeyboard(.interactively)
            .onChange(of: isTextFieldFocused) { oldValue, newValue in
                if !newValue {
                    viewModel.saveWorkouts()
                }
            }
        }
    }
    
    private func addExercise() {
        workout.exercises.append(Exercise(name: "", completed: false, notes: "", sets: []))
    }
    
    private func deleteExercise(at offsets: IndexSet) {
        workout.exercises.remove(atOffsets: offsets)
    }
}

struct WorkoutDetailView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutListView(viewModel: WorkoutViewModel())
    }
}

