import SwiftUI

struct WorkoutsPageView: View {
    @ObservedObject var controller = WorkoutController.shared
    @State private var selectedWorkoutID: UUID? = nil

    var body: some View {
        NavigationStack {
            VStack(spacing: 5) {
                
                // Workout text
                HStack {
                    Text("Workouts")
                        .font(.title)
                        .bold()
                        .padding(.leading)
                    Spacer()
                }
                .padding(.top) // Add padding at the top
                
                // Add workout button
                HStack {
                    Button(action: {
                        selectedWorkoutID = controller.addWorkout(providedDate: Date())
                    })
                        {
                        HStack {
                            Image(systemName: "plus.circle.fill")
                                .foregroundColor(.blue)
                            Text("New Workout")
                        }
                    }
                }
                .padding(.top)
                .buttonStyle(.bordered)
                
                ScrollView {
                    
                    // Loop through view models
                    ForEach(Array(controller.viewModels), id: \.key) { yearMonth, viewModel in
                        VStack {
                            // Year and month display
                            HStack {
                                Text("\(String(yearMonth.year)) \(DateService.getMonthName(for: yearMonth.month))")
                            }
                            
                            // Display workouts
                            ForEach(viewModel.workouts) { workout in
                                HStack {
                                    Text(workout.name)
                                    Text(workout.date)
                                }
                            }
                            
                        }
                    }
                    
                }
                
            }/*
            .navigationDestination(isPresented: Binding(
                get: { selectedWorkoutID != nil },
                set: { newID in
                    if !newID { selectedWorkoutID = nil }
                }
            )) {
                let workoutBinding = WorkoutViewModel(day: nil).binding(for: selectedWorkoutID!)
                WorkoutDetailView(workout: workoutBinding)
                EmptyView()
            }*/
        }
    }

    /*
    private func deleteWorkout(at offsets: IndexSet) {
        // Ensure that the offsets are within the bounds of the workouts array
        guard let indexToRemove = offsets.first, indexToRemove < viewModel.workouts.count else {
            return
        }
        
        let workout = viewModel.workouts[indexToRemove]
        WorkoutService.shared.deleteWorkout(workout: workout, from: viewModel)
        
        selectedWorkoutID = nil
    }*/
}


struct WorkoutView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutsPageView()
    }
}
