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
                VStack(alignment: .leading, spacing: 6) {
                    Text(workoutViewModel.name)
                        .font(.headline)
                        .foregroundColor(.primary)
                    
                    Text("\(DateService.getWeekday(for: workoutViewModel.rawDate)) \(workoutViewModel.day)")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                
                Spacer()
            }
            .padding([.leading, .trailing], 3)
            .padding([.bottom, .top], 5)
        }
        
    }
}
