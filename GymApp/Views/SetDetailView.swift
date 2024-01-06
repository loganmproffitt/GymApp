//
//  SetDetailView.swift
//  GymApp
//
//  Created by Logan Proffitt on 1/2/24.
//

import SwiftUI

struct SetDetailView: View {
    @Binding var set: Set
    @ObservedObject var viewModel = WorkoutViewModel.shared
    @FocusState private var isTextFieldFocused: Bool

    var body: some View {
        HStack(spacing: 0) {
            TextField("Weight", text: $set.weight, onCommit: viewModel.saveWorkouts)
                .keyboardType(.decimalPad)
                .multilineTextAlignment(.trailing)
                .textFieldStyle(PlainTextFieldStyle())
                .padding()
                .onDisappear {
                    viewModel.saveWorkouts()
                }
                .onChange(of: isTextFieldFocused) { oldValue, isFocused in
                    if !isFocused {
                        viewModel.saveWorkouts()
                    }
                }
            Text("x")
                .font(.footnote)
            TextField("Reps", text: $set.reps, onCommit: viewModel.saveWorkouts)
                .keyboardType(.decimalPad)
                .multilineTextAlignment(.leading)
                .textFieldStyle(PlainTextFieldStyle())
                .padding()
                .onDisappear {
                    viewModel.saveWorkouts()
                }
                .onChange(of: isTextFieldFocused) { oldValue, isFocused in
                    if !isFocused {
                        viewModel.saveWorkouts()
                    }
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
