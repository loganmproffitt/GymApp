import SwiftUI
import RealmSwift

struct WorkoutsPageView: View {
    @ObservedObject var workoutsController = WorkoutGroupsController.shared
    @State private var selectedWorkoutID: ObjectId? = nil
    @State private var date = Date()

    var body: some View {
        NavigationStack {
            
            VStack(spacing: 5) {
                
                // Top bar
                HStack {
                    // Workouts text
                    Text("Workouts")
                        .font(.title)
                        .bold()
                        .padding(.leading)
                    
                    Spacer()
                    
                    // Calendar picker
                    DatePicker(
                        "",
                        selection: $date,
                        displayedComponents: [.date]
                    )
                    .datePickerStyle(.compact)
                    .labelsHidden()
                    .background(Color.clear)
                    .cornerRadius(10)
                    .shadow(radius: 10)
                    .transition(.slide)
                    .padding(.trailing)
                    // Add workout button (current date)
                    Button(action: {
                        withAnimation {
                            selectedWorkoutID = workoutsController.addWorkout(providedDate: date)
                            date = Date()
                    }}) {
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 40, height: 40)
                            .foregroundColor(.blue)
                            .padding(.trailing)
                    }

                }
                .padding(.top) // Add padding at the top
                
                // List view models
                List {
                    WorkoutGroupsView()
                }
                .scrollDismissesKeyboard(.interactively)
                
            }
        }
    }
}


struct WorkoutView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutsPageView()
    }
}
