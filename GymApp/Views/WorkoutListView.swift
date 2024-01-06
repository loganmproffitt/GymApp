//
//  WorkoutView.swift
//  GymApp
//
//  Created by Logan Proffitt on 1/2/24.
//

import SwiftUI

struct WorkoutListView: View {
    @ObservedObject var viewModel = WorkoutViewModel()

        var body: some View {
            NavigationView {
                VStack(spacing: 5) {
                    // Workout title
                    HStack {
                        Text("Workouts")
                            .font(.title) // Make the font larger to resemble a title
                            .bold()
                            .padding(.leading) // Add padding to align with the leading edge
                        Spacer() // Pushes the TextField to the left
                    }
                    .padding(.top) // Add padding at the top
                    List {
                        ForEach(viewModel.workouts) { workout in
                            NavigationLink(destination: WorkoutDetailView(workout: viewModel.binding(for: workout.id))) {
                                Text(workout.date)
                            }
                        }
                        .onDelete(perform: deleteWorkout)
                        HStack {
                            Button(action: addWorkout) {
                                HStack {
                                    Text("Add Workout")
                                    Image(systemName: "plus.circle.fill")
                                }
                            }
                        }
                    }
                }
            }
        }
    
    private func addWorkout() {
        // Get date and convert to string for default workout name
        let currentDate = Date()
        let formatter = DateFormatter()
        //formatter.dateFormat = "yyyy-MM-dd"
        formatter.dateFormat = "MM/dd/yy"
        let dateString = formatter.string(from: currentDate)

        viewModel.workouts.append(Workout(date: dateString, exercises: [Exercise.default]))
    }
    
    private func deleteWorkout(at offsets: IndexSet) {
        viewModel.workouts.remove(atOffsets: offsets)
    }
}


struct WorkoutView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutListView()
    }
}
