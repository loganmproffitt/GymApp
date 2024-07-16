import SwiftUI

struct WorkoutListView: View {
    @ObservedObject var viewModel = WorkoutViewModel.shared
    @State private var selectedWorkoutID: UUID? = nil

    var body: some View {
        NavigationStack {
            VStack(spacing: 5) {
                // Workout title
                HStack {
                    Text("Workouts")
                        .font(.title)
                        .bold()
                        .padding(.leading)
                    Spacer() // Pushes the TextField to the left
                }
                .padding(.top) // Add padding at the top
                HStack {
                    Button(action: {
                        selectedWorkoutID = WorkoutService.shared.addWorkout(viewModel: viewModel)
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
                List {
                    ForEach(viewModel.workouts) { workout in
                        NavigationLink(destination: WorkoutDetailView(workout: viewModel.binding(for: workout.id))) {
                            HStack {
                                Text(workout.name)
                                Spacer()
                                Text(workout.date)
                                    .font(.caption)
                                    .foregroundColor(.gray)
                                    .padding(.trailing)
                            }
                        }
                    }
                    .onDelete(perform: deleteWorkout)
                }
            }
            .navigationDestination(isPresented: Binding(
                get: { selectedWorkoutID != nil },
                set: { newID in
                    if !newID { selectedWorkoutID = nil }
                }
            )) {
                WorkoutDetailView(workout: viewModel.binding(for: selectedWorkoutID ?? UUID()))
                EmptyView()
            }
        }
    }

    
    private func deleteWorkout(at offsets: IndexSet) {
        // Ensure that the offsets are within the bounds of the workouts array
        guard let indexToRemove = offsets.first, indexToRemove < viewModel.workouts.count else {
            return
        }
        
        let workout = viewModel.workouts[indexToRemove]
        WorkoutService.shared.deleteWorkout(workout: workout, from: viewModel)
        
        selectedWorkoutID = nil
    }
}


struct WorkoutView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutListView()
    }
}
