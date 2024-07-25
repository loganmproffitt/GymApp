import SwiftUI

struct ExerciseDetailView: View {
    
    @Binding var exercise: Exercise
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
                 NotesView(exercise: $exercise)
             }
            
            
            // Display sets
            ForEach($exercise.sets.indices, id: \.self) { index in
                HStack {
                    Spacer()
                    
                    // Add set
                    SetDetailView(set: $exercise.sets[index])
                    
                    Spacer()
                    /*
                     // Add delete button
                     Button(action: { deleteSet(at: IndexSet(integer: index)) }) {
                     Image(systemName: "trash")
                     .foregroundColor(.red)
                     }
                     .padding(.trailing)
                     .buttonStyle(BorderlessButtonStyle())*/
                }
            }
            
            
            /*
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
             }*/
        }
        
        
    }
    
    struct ExerciseDetailView_Previews: PreviewProvider {
        static var previews: some View {
            WorkoutsPageView()
        }
    }
}
