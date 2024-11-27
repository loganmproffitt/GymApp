import SwiftUI

struct ExerciseCardView: View {
    
    @ObservedObject var exerciseViewModel: ExerciseViewModel
    
    @State private var setsVisible = false
    @State private var notesVisible = false
    @State private var setsValue = ""
    
    init(exerciseViewModel: ExerciseViewModel) {
        self.exerciseViewModel = exerciseViewModel
    }
    
    //@ObservedObject var viewModel = WorkoutViewModel.shared
    @FocusState private var isTextFieldFocused: Bool
    
    var body: some View {
        
        VStack {
            HStack {
                
                // Check box
                Button(action: {
                    exerciseViewModel.toggleCheckbox()
                }) {
                    Image(systemName: exerciseViewModel.completed ? "checkmark.circle.fill" : "circle")
                        .foregroundColor(exerciseViewModel.completed ? .yellow : .gray)
                        .font(.title2)
                        .padding(3)
                }
                .buttonStyle(BorderlessButtonStyle())
                
                
                // Exercise name (modifiable)
                TextField("Exercise", text: $exerciseViewModel.name)
                    .padding(.leading, 3)
                    .frame(minWidth: 0, maxWidth: 300, alignment: .leading)
                    .multilineTextAlignment(.leading)
                    .onChange(of: exerciseViewModel.name) { oldValue, newValue in
                        exerciseViewModel.name = newValue
                    }
                
                Spacer()
                
                
                // Display details button
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
                ExerciseDetailView()
                    .environmentObject(exerciseViewModel)
            }
        }
    }
}


struct ExerciseCardView_Previews: PreviewProvider {
    struct PreviewWrapper: View {
        @State private var exercise = Exercise(name: "Bench Press", completed: false, notes: "", setCount: "", setCountModified: false,
                        sets: [Set(weight: "135", reps: "12"), Set(weight: "165", reps: "8")])
        var body: some View {
            ExerciseCardView(exerciseViewModel: ExerciseViewModel(exercise: exercise))
        }
    }

    static var previews: some View {
        PreviewWrapper()
    }
}

