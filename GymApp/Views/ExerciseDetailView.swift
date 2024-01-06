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
    @State private var notesVisible = false
    @ObservedObject var viewModel = WorkoutViewModel.shared
    @FocusState private var isTextFieldFocused: Bool
    
    var body: some View {
        
        VStack {
            HStack {
                // Check box
                Button(action: {
                    exercise.completed.toggle()
                    viewModel.saveWorkouts()
                }) {
                    Image(systemName: exercise.completed ? "checkmark.circle.fill" : "circle")
                        .foregroundColor(exercise.completed ? .yellow : .gray)
                        .font(.title2) // Smaller font size for the checkbox
                        .padding(5) // Reduced padding around the checkbox
                }
                .buttonStyle(BorderlessButtonStyle())
                
                // Exercise name (modifiable)
                TextField(exercise.name, text: $exercise.name, onCommit: viewModel.saveWorkouts)
                    .padding(.leading)
                    //.textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(minWidth: 0, maxWidth: 300, alignment: .leading)
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
                
                HStack(spacing: -15) {
                    // Sets button
                    Button(action: {
                        withAnimation {
                            setsVisible.toggle()
                        }
                    }) {
                        HStack {
                            //Text("Sets")
                               // .font(.footnote)
                            Image(systemName: setsVisible ? "chevron.up" : "chevron.down")
                        }
                        .padding()
                    }
                    .contentShape(Rectangle())
                    .buttonStyle(BorderlessButtonStyle())
                }
            }
            if (setsVisible)
            {
            // Sets with outline
            VStack(spacing: -5) {
                
                
                    // Notes button
                    Button(action: {
                        withAnimation {
                            notesVisible.toggle()
                        }
                    }) {
                        HStack {
                            Text("Notes")
                                .font(.footnote)
                            Image(systemName: "note.text")
                        }
                        .padding()
                    }
                    .contentShape(Rectangle())
                    .buttonStyle(BorderlessButtonStyle())
                    
                    // Notes section
                    if (notesVisible)
                    {
                        TextEditor(text: $exercise.notes)
                            .frame(height: 100)
                            .onDisappear {
                                viewModel.saveWorkouts()
                            }
                            .onChange(of: isTextFieldFocused) { oldValue, isFocused in
                                if !isFocused {
                                    viewModel.saveWorkouts()
                                }
                            }
                            .padding(2) // Optional, for internal padding within the TextEditor
                            .background(Color(red: 0.15, green: 0.15, blue: 0.15))
                            .cornerRadius(10)
                    }
                    
                    // Display sets
                    ForEach($exercise.sets.indices, id: \.self) { index in
                        HStack {
                            // Add set
                            SetDetailView(set: $exercise.sets[index])
                            
                            Spacer()
                            
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
                                Text("Add Set")
                                    .font(.footnote)
                                Image(systemName: "plus.circle.fill")
                            }
                        }
                    }
                    .padding(.top, 5)
                    .buttonStyle(BorderlessButtonStyle())
                }
                .padding([.horizontal, .bottom])
            }
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
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
        @State private var exercise = Exercise(name: "Bench Press", completed: false, notes: "",
                        sets: [Set(weight: "135", reps: "12"), Set(weight: "165", reps: "8")])
        var body: some View {
            ExerciseDetailView(exercise: $exercise)
        }
    }

    static var previews: some View {
        PreviewWrapper()
    }
}
