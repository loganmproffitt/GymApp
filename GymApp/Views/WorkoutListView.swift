import SwiftUI

struct WorkoutListView: View {
    
    @ObservedObject var viewModel: WorkoutListViewModel
    
    var body: some View {
        
        List {
            Section(header: Text("\(DateService.getMonthName(for: viewModel.yearMonth.month))").font(.title2).bold()
                .padding([.top, .leading]))
            {
                // Display workouts
                ForEach(viewModel.workouts.indices, id: \.self) { index in
                    NavigationLink(destination:
                                    WorkoutView(workoutViewModel: viewModel.workouts[index])) {
                        HStack {
                            Text("\(viewModel.workouts[index].name)")
                            Spacer()
                            Text("\(viewModel.workouts[index].formattedDate)")
                        }
                        .padding()
                    }
                }
                .onDelete { indexSet in
                    withAnimation {
                        if let index = indexSet.first {
                            viewModel.removeWorkout(at: index)
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
}
