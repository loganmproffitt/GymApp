//
//  ExerciseDetailView.swift
//  GymApp
//
//  Created by Logan Proffitt on 1/2/24.
//

import SwiftUI

struct ExerciseDetailView: View {
    @Binding var exercise: Exercise
    @State private var setsVisible = false
    @ObservedObject var viewModel = WorkoutViewModel.shared
    @FocusState private var isTextFieldFocused: Bool
    
    var body: some View {
        
        VStack {
            HStack {
                // Exercise name (modifiable)
                TextField(exercise.name, text: $exercise.name, onCommit: viewModel.saveWorkouts)
                    .padding(.leading)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(minWidth: 0, maxWidth: 200, alignment: .leading)
                    .multilineTextAlignment(.leading)
                    .onDisappear {
                        viewModel.saveWorkouts()
                    }
                    .onChange(of: isTextFieldFocused) { oldValue, isFocused in
                        if !isFocused {
                            viewModel.saveWorkouts()
                        }
                    }
                
                Spacer()
                
                Button(action: {
                    withAnimation {
                        setsVisible.toggle()
                    }
                }) {
                    HStack {
                        Text("Sets")
                            .font(.footnote)
                        Image(systemName: setsVisible ? "chevron.up" : "chevron.down")
                    }
                    .padding()
                }
                .contentShape(Rectangle())
                .buttonStyle(BorderlessButtonStyle())
                
            }
            
            // Sets with outline
            VStack(spacing: -5) {
                
                if (setsVisible)
                {
                    // Weight / rep labels
                    HStack(spacing: 0) {
                        Text("Weight")
                            .multilineTextAlignment(.trailing)
                            .textFieldStyle(PlainTextFieldStyle())
                            .padding()
                            .font(.footnote)
                        Text("x")
                            .font(.footnote)
                        Text("Reps")
                            .multilineTextAlignment(.trailing)
                            .textFieldStyle(PlainTextFieldStyle())
                            .padding()
                            .font(.footnote)
                    }
                    
                    // Display sets
                    ForEach($exercise.sets.indices, id: \.self) { index in
                        HStack {
                            // Add set
                            SetDetailView(set: $exercise.sets[index])
                            
                            // Add delete button
                            Button(action: { deleteSet(at: IndexSet(integer: index)) }) {
                             Image(systemName: "trash")
                             .foregroundColor(.red)
                             }
                             .padding(.trailing)
                             .buttonStyle(BorderlessButtonStyle())
                        }
                    }
                    
                    // Add set button
                    HStack {
                        Button(action: addSet) {
                            HStack {
                                Image(systemName: "plus.circle.fill")
                            }
                        }
                    }
                    .padding()
                    .buttonStyle(BorderlessButtonStyle())
                }
            }
            .background(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
        }
    }
    
    private func addSet() {
        exercise.sets.append(Set.default)
        viewModel.saveWorkouts()
    }
    
    private func deleteSet(at offsets: IndexSet) {
        exercise.sets.remove(atOffsets: offsets)
        viewModel.saveWorkouts()
    }
}

struct ExerciseDetailView_Previews: PreviewProvider {
    struct PreviewWrapper: View {
        @State private var exercise = Exercise(name: "Bench Press",
                        sets: [Set(weight: "135", reps: "12"), Set(weight: "165", reps: "8")])
        var body: some View {
            ExerciseDetailView(exercise: $exercise)
        }
    }

    static var previews: some View {
        PreviewWrapper()
    }
}
