//
//  KeyboardResponder.swift
//  GymApp
//
//  Created by Logan Proffitt on 1/5/24.
//

import Foundation
import SwiftUI

struct DismissKeyboardOnTap: ViewModifier {
    func body(content: Content) -> some View {
        content
            .onTapGesture {
                hideKeyboard()
            }
    }

    private func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
