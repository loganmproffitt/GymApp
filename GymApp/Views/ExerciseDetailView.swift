import SwiftUI

struct ExerciseDetailView: View {
    
    @EnvironmentObject var exerciseViewModel: ExerciseViewModel
    @State private var notesVisible = false

    @FocusState private var isTextFieldFocused: Bool
    
    var body: some View {
        
        // Sets with outline
        VStack() {
            
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
                .contentShape(Rectangle())
                .foregroundColor(.blue)
            }
            .buttonStyle(BorderlessButtonStyle())
            
            // Notes section
            if notesVisible {
                NotesView()
                    .environmentObject(exerciseViewModel)
                    .padding([.top, .bottom])
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
                        withAnimation {
                            exerciseViewModel.deleteSet(at: index)
                        }
                    }) {
                        Image(systemName: "trash")
                            .foregroundColor(.red)
                    }
                    .padding(.trailing)
                }
                .contentShape(Rectangle())
                .buttonStyle(BorderlessButtonStyle())
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
