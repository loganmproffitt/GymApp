//
//  WorkoutViewModel.swift
//  GymApp
//
//  Created by Logan Proffitt on 1/2/24.
//

import Foundation
import SwiftUI

class WorkoutViewModel: ObservableObject {
    @Published var workouts: [Workout] = Workout.sampleData
    
    func binding(for workoutID: UUID) -> Binding<Workout> {
            return Binding<Workout>(
                get: {
                    self.workouts.first { $0.id == workoutID } ?? Workout.default // Provide a default or handle nil
                },
                set: {
                    if let index = self.workouts.firstIndex(where: { $0.id == workoutID }) {
                        self.workouts[index] = $0
                    }
                }
            )
        }
}
