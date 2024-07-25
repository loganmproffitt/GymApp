import SwiftUI

struct NotesView: View {
    
    @Binding var exercise: Exercise
    
    var body: some View {
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
}
