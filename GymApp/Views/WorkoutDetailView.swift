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
            
            // Workout name and date
            HStack {
                TextField(workout.name, text: $workout.name, onCommit: viewModel.saveWorkouts)
                    .font(.title)
                    .padding(.leading)
                    .onDisappear {
                        viewModel.saveWorkouts()
                    }
                    .onChange(of: isTextFieldFocused) { oldValue, isFocused in
                        if !isFocused {
                            viewModel.saveWorkouts()
                        }
                    }
                Spacer() // Pushes the TextField to the left
                
                Text(workout.date)
                    .font(.caption)
                    .foregroundColor(.gray)
                    .padding(.trailing)
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
                        Button(action: addExercise) {
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
                    viewModel.saveWorkouts()
                }
            }
        }
    }
    
    private func addExercise() {
        workout.exercises.append(Exercise(name: "", completed: false, notes: "", setCount: "", setCountModified: false, sets: []))
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

