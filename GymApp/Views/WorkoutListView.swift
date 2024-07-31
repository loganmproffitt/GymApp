import SwiftUI
import RealmSwift

struct WorkoutListView: View {
    
    @ObservedObject var viewModel: WorkoutListViewModel
    
    var body: some View {
        
        List {
            Section(header: Text("\(DateService.getMonthName(for: viewModel.yearMonth.month))").font(.title2).bold()
                .padding([.top, .leading]))
            {
                // Display workouts
                ForEach(viewModel.workouts.indices, id: \.self) { index in
                    WorkoutCardView()
                        .environmentObject(viewModel.workouts[index])
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
        //.scrollDisabled(true)
    }
    
    struct WorkoutListView_Previews: PreviewProvider {
        static var previews: some View {
            WorkoutsPageView()
        }
    }
}
