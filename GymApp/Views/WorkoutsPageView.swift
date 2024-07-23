import SwiftUI

struct WorkoutsPageView: View {
    @ObservedObject var controller = WorkoutController.shared
    @State private var selectedWorkoutID: UUID? = nil

    var body: some View {
        NavigationStack {
            
            ZStack {
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
                    
                    // List view models
                    ViewModelListView()
                }
                
                // Add workout button
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Button(action: {
                            selectedWorkoutID = controller.addWorkout(providedDate: Date())
                        }) {
                                Image(systemName: "plus.circle.fill")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 48, height: 48)
                                    .foregroundColor(.blue)
                            .padding()
                        }
                        .padding()
                    }
                }
            }
            
                /*
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
