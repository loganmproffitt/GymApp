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
                        .minimumScaleFactor(0.5)
                    
                    Text(DateService.getStringDate(for: workoutViewModel.rawDate))
                        .font(.caption)
                        .foregroundColor(.gray)
                        .minimumScaleFactor(0.5)
                }
                
                Spacer()
            }
            .padding([.leading, .trailing], 3)
            .padding([.bottom, .top], 5)
        }
        
    }
}
