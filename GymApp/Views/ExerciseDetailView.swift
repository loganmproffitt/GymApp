import SwiftUI

struct ExerciseDetailView: View {
    
    @EnvironmentObject var exerciseViewModel: ExerciseViewModel
    @State private var setsVisible = false
    @State private var notesVisible = false

    @FocusState private var isTextFieldFocused: Bool
    
    var body: some View {
        
        // Sets with outline
        VStack(spacing: -5) {
            // Notes button
            Button(action: {
                withAnimation {
                    //notesVisible.toggle()
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
                NotesView()
                .environmentObject(exerciseViewModel)
            }
            
            
            // Display sets
            ForEach(exerciseViewModel.exercise.sets.indices, id: \.self) { index in
                HStack {
                    Spacer()
                    
                    // Add set detail view
                    SetDetailView(setViewModel: SetViewModel(set: exerciseViewModel.exercise.sets[index]))
                    
                    Spacer()
                    
                    // Add delete button
                    Button(action: {
                        exerciseViewModel.deleteSet(at: index)
                    }) {
                        Image(systemName: "trash")
                            .foregroundColor(.red)
                    }
                    .padding(.trailing)
                }
            }
            
            // Add set button
            HStack {
                Button(action: exerciseViewModel.addSet) {
                    HStack {
                        Text("Add Set")
                            .font(.footnote)
                        Image(systemName: "plus.circle.fill")
                        
                    }
                }
                .padding(.top, 5)
                .buttonStyle(BorderlessButtonStyle())
            }
        }
    }
    
    struct ExerciseDetailView_Previews: PreviewProvider {
        static var previews: some View {
            WorkoutsPageView()
        }
    }
}
