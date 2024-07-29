import SwiftUI

struct WorkoutListView: View {
    
    @ObservedObject var viewModel: WorkoutListViewModel
    
    var body: some View {
        List {
            // Display workouts
            ForEach(viewModel.workouts.indices, id: \.self) { index in
                NavigationLink(destination:
                    WorkoutView(controller: WorkoutController(workout: viewModel.workouts[index], viewModel: viewModel))) {
                    HStack {
                        Text("\(viewModel.workouts[index].name)")
                        Spacer()
                        Text("\(viewModel.workouts[index].formattedDate)")
                    }
                    .padding()
                }
            }
            .onDelete { indexSet in
                if let index = indexSet.first {
                    viewModel.removeWorkout(at: index)
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
