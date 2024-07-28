import SwiftUI

struct SetDetailView: View {
    
    @ObservedObject var setViewModel: SetViewModel
    @FocusState private var isTextFieldFocused: Bool

    var body: some View {
        HStack(spacing: 0) {
            TextField("Weight", text: $setViewModel.weight)
                .keyboardType(.decimalPad)
                .multilineTextAlignment(.trailing)
                .textFieldStyle(PlainTextFieldStyle())
                .padding()
                .onChange (of: setViewModel.weight) { oldValue, newValue in
                    setViewModel.weight = newValue
                }
            
            Text("x")
                .font(.footnote)
                .padding(.horizontal, 5)
            
            TextField("Reps", text: $setViewModel.reps)
                .keyboardType(.decimalPad)
                .multilineTextAlignment(.leading)
                .textFieldStyle(PlainTextFieldStyle())
                .padding()
                .onChange (of: setViewModel.reps) { oldValue, newValue in
                    setViewModel.reps = newValue
                }
            }
        }
    }

    struct SetDetailView_Previews: PreviewProvider {
        struct PreviewWrapper: View {
            @State private var previewSet = Set(weight: "100.0", reps: "10")

            var body: some View {
                SetDetailView(setViewModel: SetViewModel(set: previewSet))
            }
        }

    static var previews: some View {
        PreviewWrapper()
    }
}
