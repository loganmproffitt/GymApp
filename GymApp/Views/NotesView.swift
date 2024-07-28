import SwiftUI

struct NotesView: View {
    
    @EnvironmentObject var exerciseViewModel: ExerciseViewModel
    
    var body: some View {
        TextEditor(text: $exerciseViewModel.notes)
        .frame(height: 100)
        .onChange (of: exerciseViewModel.notes) { oldValue, newValue in
            exerciseViewModel.notes = newValue
        }
        .padding(2) // Optional, for internal padding within the TextEditor
        .background(Color(red: 0.15, green: 0.15, blue: 0.15))
        .cornerRadius(10)
        .frame(minWidth: 0, maxWidth: .infinity)
    }
}
