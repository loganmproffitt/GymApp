import SwiftUI
import RealmSwift

struct WorkoutListView: View {
    
    @ObservedObject var viewModel: WorkoutListViewModel
    @State var isExpanded = true
    
    var body: some View {
        
        Section(header:
            HStack {
                
                // Month text
                Text("\(DateService.getMonthName(for: viewModel.yearMonth.month)) \(String(viewModel.yearMonth.year))")
                    .font(.title2)
                    .bold()
                    .padding([.top, .trailing])
                    .foregroundColor(.yellow)

                Spacer()
            
                // Button for hiding month
                Button(action: {
                    withAnimation {
                        isExpanded.toggle()
                    }
                }) {
                Image(systemName: isExpanded ? "chevron.down" : "chevron.right")
                    .padding([.top, .trailing])
                    .foregroundColor(.gray)
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
                            viewModel.deleteWorkout(at: index)
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
