import SwiftUI

struct SetDetailView: View {
    
    @Binding var set: Set
    @FocusState private var isTextFieldFocused: Bool

    var body: some View {
        HStack(spacing: 0) {
            TextField("Weight", text: $set.weight)
                .keyboardType(.decimalPad)
                .multilineTextAlignment(.trailing)
                .textFieldStyle(PlainTextFieldStyle())
                .padding()
                .onChange (of: set.weight) {
                    //viewModel.saveWorkouts()
                }
            
            Text("x")
                .font(.footnote)
                .padding(.horizontal, 5)
            
            TextField("Reps", text: $set.reps)
                .keyboardType(.decimalPad)
                .multilineTextAlignment(.leading)
                .textFieldStyle(PlainTextFieldStyle())
                .padding()
                .onChange (of: set.reps) {
                    //viewModel.saveWorkouts()
                }
            }
        }
    }

    struct SetDetailView_Previews: PreviewProvider {
        struct PreviewWrapper: View {
            @State private var previewSet = Set(weight: "100.0", reps: "10")

            var body: some View {
                SetDetailView(set: $previewSet)
            }
        }

    static var previews: some View {
        PreviewWrapper()
    }
}
