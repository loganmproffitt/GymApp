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
                        //modifySetCount()
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
            
            // Display exercise details
            if (setsVisible)
            {
                ExerciseDetailView(exercise: $exercise)
            }
        }/*
        .onAppear {
            if (exercise.setCountModified)
            {
                setsValue = exercise.setCount
            }
            else
            {
                setsValue = String(exercise.sets.count)
            }
        }*/
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