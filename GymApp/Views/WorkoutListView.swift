import SwiftUI
import RealmSwift

struct WorkoutListView: View {
    
    @ObservedObject var viewModel: WorkoutListViewModel
    @State var isExpanded = true
    
    var body: some View {
        
        Section(header:
            HStack {
                Text("\(DateService.getMonthName(for: viewModel.yearMonth.month))")
                    .font(.title2)
                    .bold()
                    .padding([.top, .leading])
                    //.foregroundColor(.primary)
                Spacer()
                
                // Button for hiding month
                Button(action: {
                    withAnimation {
                        isExpanded.toggle()
                    }
                }) {
                Image(systemName: isExpanded ? "chevron.down" : "chevron.right")
                    .padding([.top, .trailing])
                    .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                }
            }
        ) {
            // Check whether to expand
            if isExpanded {
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
    }
    
    struct WorkoutListView_Previews: PreviewProvider {
        static var previews: some View {
            WorkoutsPageView()
        }
    }
}
