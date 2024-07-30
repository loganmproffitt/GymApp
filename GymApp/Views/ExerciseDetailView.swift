import SwiftUI

struct ExerciseDetailView: View {
    
    @EnvironmentObject var exerciseViewModel: ExerciseViewModel
    @State private var setsVisible = false
    @State private var notesVisible = false

    @FocusState private var isTextFieldFocused: Bool
    
    var body: some View {
        
        // Sets with outline
        VStack() {//spacing: -5) {
            
            // Notes label
            HStack {
                Text("Notes")
                    .font(.footnote)
                Image(systemName: "note.text")
            }
                .contentShape(Rectangle())
                .buttonStyle(BorderlessButtonStyle())
            
            // Notes section
            NotesView()
            .environmentObject(exerciseViewModel)
            .padding([.top, .bottom])
 
            // Sets label
            HStack {
                Text("Sets")
                    .font(.footnote)
                Image(systemName: "list.bullet")
            }
                .padding(.top, 0.8)
                .contentShape(Rectangle())
                .buttonStyle(BorderlessButtonStyle())
            
            Divider()
            .padding(.top)
            
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
