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
                Text("\(workoutViewModel.formattedDate)")
            }
            .padding()
        }
        
    }
}
