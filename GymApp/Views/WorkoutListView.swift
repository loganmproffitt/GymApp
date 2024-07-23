import SwiftUI

struct WorkoutListView: View {
    
    var viewModel: WorkoutViewModel
    
    var body: some View {
        List {
            VStack {
                // Display workouts
                ForEach(viewModel.workouts) { workout in
                    NavigationLink(destination: WorkoutDetailView(workout: viewModel.binding(for: workout.id))) {
                        HStack {
                            Text(workout.name)
                            Spacer()
                            Text(workout.date)
                        }
                        .padding()
                    }
                }
            }
        }
    }
}

struct WorkoutListView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutsPageView()
    }
}
