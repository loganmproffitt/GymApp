import SwiftUI
import Foundation

struct WorkoutCardView: View {
    
    @EnvironmentObject var workoutViewModel: WorkoutViewModel
    
    var body: some View {
        NavigationLink(destination:
            WorkoutView()
            .environmentObject(workoutViewModel)
        ) {
            HStack {
                Text(workoutViewModel.name)
                Spacer()
                Text("\(DateService.getWeekday(for: workoutViewModel.rawDate)),\n\(DateService.getMonthName(for: workoutViewModel.month)) \(workoutViewModel.day)")
                    .font(.headline)
            }
            .padding()
        }
        
    }
}
