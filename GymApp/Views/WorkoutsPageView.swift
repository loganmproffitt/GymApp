import SwiftUI
import RealmSwift

struct WorkoutsPageView: View {
    @ObservedObject var workoutsController = WorkoutGroupsController.shared
    @State private var selectedWorkoutID: ObjectId? = nil

    var body: some View {
        NavigationStack {
            
            ZStack {
                VStack(spacing: 5) {
                    
                    // Workout text
                    HStack {
                        Text("Workouts")
                            .font(.title)
                            .bold()
                            .padding(.leading)
                        Spacer()
                    }
                    .padding(.top) // Add padding at the top
                    
                    // List view models
                    WorkoutGroupsView()
                }
                
                // Add workout button
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Button(action: {
                            selectedWorkoutID = workoutsController.addWorkout(providedDate: Date())
                        }) {
                                Image(systemName: "plus.circle.fill")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 48, height: 48)
                                    .foregroundColor(.blue)
                            .padding()
                        }
                        .padding()
                    }
                }
            }
            
                /*
            .navigationDestination(isPresented: Binding(
                get: { selectedWorkoutID != nil },
                set: { newID in
                    if !newID { selectedWorkoutID = nil }
                }
            )) {
                let workoutBinding = WorkoutViewModel(day: nil).binding(for: selectedWorkoutID!)
                WorkoutDetailView(workout: workoutBinding)
                EmptyView()
            }*/
        }
    }
}


struct WorkoutView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutsPageView()
    }
}
