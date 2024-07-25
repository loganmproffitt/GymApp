import SwiftUI

struct ExerciseCardView: View {
    @Binding var exercise: Exercise
    @State private var setsVisible = false
    @State private var notesVisible = false
    
    @State private var setsValue = ""
    
    //@ObservedObject var viewModel = WorkoutViewModel.shared
    @FocusState private var isTextFieldFocused: Bool
    
    var body: some View {
        
        VStack {
            HStack {
                
                // Check box
                Button(action: {
                    exercise.completed.toggle()
                   // viewModel.saveWorkouts()
                }) {
                    Image(systemName: exercise.completed ? "checkmark.circle.fill" : "circle")
                        .foregroundColor(exercise.completed ? .yellow : .gray)
                        .font(.title2) // Smaller font size for the checkbox
                        .padding(3) // Reduced padding around the checkbox
                }
                .buttonStyle(BorderlessButtonStyle())
                
                
                // Exercise name (modifiable)
                TextField("Exercise", text: $exercise.name)
                    .padding(.leading, 3)
                    .frame(minWidth: 0, maxWidth: 300, alignment: .leading)
                    .multilineTextAlignment(.leading)
                    .onChange (of: exercise.name) {
                        //viewModel.saveWorkouts()
                    }
                
                Spacer()

                
                // Set Count
                TextField(setsValue, text: $setsValue)
                    .onChange (of: setsValue) {
                        modifySetCount()
                    }
                    .padding(.leading, 3)
                    .frame(minWidth: 0, maxWidth: 300, alignment: .leading)
                    .multilineTextAlignment(.trailing)
                    .foregroundColor(.gray)
                    .keyboardType(.decimalPad)
                
                HStack(spacing: -15) {
                    // Sets button
                    Button(action: {
                        withAnimation {
                            setsVisible.toggle()
                        }
                    }) {
                        HStack {
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
                            .onChange (of: exercise.notes) {
                                //viewModel.saveWorkouts()
                            }
                            .padding(2) // Optional, for internal padding within the TextEditor
                            .background(Color(red: 0.15, green: 0.15, blue: 0.15))
                            .cornerRadius(10)
                            .frame(minWidth: 0, maxWidth: .infinity)
                    }
                    
                    // Display sets
                    ForEach($exercise.sets.indices, id: \.self) { index in
                        HStack {
                            Spacer()
                            
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
            }
        }
        .onAppear {
            if (exercise.setCountModified)
            {
                setsValue = exercise.setCount
            }
            else
            {
                setsValue = String(exercise.sets.count)
            }
        }
    }
    
    private func modifySetCount()
    {
        // If blank, set modified to false
        if (setsValue == "" || setsValue == "Sets")
        {
            exercise.setCountModified = false
        }
        else    // Else, set modified to true and update setCount
        {
            exercise.setCountModified = true
            exercise.setCount = setsValue
            //viewModel.saveWorkouts()
        }
    }
    
    private func updateSetCount()
    {
        // If sets not modified, set to number of sets in list
        if (exercise.setCountModified == false)
        {
            setsValue = String(exercise.sets.count)
        }
    }
    
    private func addSet() {
        exercise.sets.append(Set.default)
        updateSetCount()
        //viewModel.saveWorkouts()
    }
    
    private func deleteSet(at offsets: IndexSet) {
        exercise.sets.remove(atOffsets: offsets)
        updateSetCount()
        //viewModel.saveWorkouts()
    }
}

struct ExerciseCardView_Previews: PreviewProvider {
    struct PreviewWrapper: View {
        @State private var exercise = Exercise(name: "Bench Press", completed: false, notes: "", setCount: "", setCountModified: false,
                        sets: [Set(weight: "135", reps: "12"), Set(weight: "165", reps: "8")])
        var body: some View {
            ExerciseCardView(exercise: $exercise)
        }
    }

    static var previews: some View {
        PreviewWrapper()
    }
}
