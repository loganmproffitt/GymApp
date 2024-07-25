import SwiftUI

struct WorkoutListView: View {
    
    var viewModel: WorkoutsViewModel
    
    var body: some View {
        List {
            VStack {
                // Display workouts
                ForEach(viewModel.workouts.indices, id: \.self) { index in
                    NavigationLink(destination: 
                                    WorkoutDetailView(controller: WorkoutController(workout: viewModel.workouts[index], viewModel: viewModel))) {
                        HStack {
                            Text("\(viewModel.workouts[index].name)")
                            Spacer()
                            Text("\(viewModel.workouts[index].date)")
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
