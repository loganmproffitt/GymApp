import SwiftUI

struct WorkoutListView: View {
    @ObservedObject var viewModel = WorkoutViewModel.shared

        var body: some View {
            NavigationView {
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
                        HStack {
                            Button(action: addWorkout) {
                                HStack {
                                    Image(systemName: "plus.circle.fill")
                                        .foregroundColor(.blue)
                                    Text("New Workout")
                                }
                            }
                        }
                    }
                }
            }
        }
     
    private func addWorkout() {
        // Get date
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yy"
        let dateString = formatter.string(from: date)
        
        // Get weekday
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        let weekday = dateFormatter.string(from: date)

        viewModel.workouts.append(Workout(name: weekday, date: dateString, notes: "", exercises: [Exercise.default]))
        viewModel.saveWorkouts()
    }
    
    private func deleteWorkout(at offsets: IndexSet) {
        viewModel.workouts.remove(atOffsets: offsets)
        viewModel.saveWorkouts()
    }
}


struct WorkoutView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutListView()
    }
}
