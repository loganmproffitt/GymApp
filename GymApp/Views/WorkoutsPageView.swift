import SwiftUI
import RealmSwift

struct WorkoutsPageView: View {
    
    @ObservedObject var workoutsController = WorkoutGroupsController.shared
    
    @State private var selectedWorkoutID: ObjectId? = nil
    @State private var date = Date()
    @State private var showTemplates = false
    
    @State private var newWorkoutAdded = false

    var body: some View {
        NavigationStack {
            
            ZStack {
                
                VStack() {
                    
                    // List view models
                    List {
                        WorkoutGroupsView()
                    }
                    .scrollDismissesKeyboard(.interactively)
                    
                }
                .toolbar {
                    
                    // Top tool bar
                    ToolbarItem(placement: .navigationBarLeading) {
                        // Workouts text
                        Text("Workouts")
                            .font(.title)
                            .bold()
                            .padding(.leading)
                        
                        Spacer()
                    }
                    
                    // Bottom tool bar
                    ToolbarItemGroup(placement: .bottomBar) {
                        
                        HStack {
                            // From templates
                            NavigationLink(destination: TemplatesView(onTemplateSelected: {
                                withAnimation {
                                    showTemplates = false
                                    addWorkout()
                                }
                            })
                            .environmentObject(workoutsController.newWorkout))
                            {
                                HStack {
                                    Image(systemName: "folder")
                                        .foregroundColor(.blue)
                                        .frame(width: 30, height: 30)
                                    Text("Load Template")
                                        .foregroundColor(.blue)
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                            }
                            .padding()
                            
                            Spacer()
                            
                            // Empty workout button
                            Button(action: {
                                withAnimation {
                                    workoutsController.newWorkout.name = DateService.getWeekday(for: date)
                                    addWorkout()
                                }
                            }) {
                                HStack {
                                    Image(systemName: "plus.circle.fill")
                                        .frame(width: 30, height: 30)
                                    Text("New Workout")
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                            }
                            .padding()
                        }
                    }
                    
                }
               
            }
            /*
            .navigationDestination(isPresented: $newWorkoutAdded) {
                if let workoutID = selectedWorkoutID, // Ensure workoutID exists
                   let workoutIndex = workoutsController
                       .getWorkoutListViewModel(for: date)
                       .getWorkoutIndex(for: workoutID), // Ensure index is valid
                   workoutIndex >= 0, // Safety check for a non-negative index
                   workoutIndex < workoutsController.getWorkoutListViewModel(for: date).workouts.count // Ensure index is within bounds
                {
                    let workout = workoutsController
                        .getWorkoutListViewModel(for: date)
                        .workouts[workoutIndex] // Safely access the workout

                    WorkoutView()
                        .environmentObject(workout) // Pass the fetched workout
                } else {
                    Text("Workout not found.") // Fallback for invalid data
                }
            }*/
        }
    }
    
    
    // Helper for adding workout
    private func addWorkout() {
        // Set date info and add workout, storing the new ID
        workoutsController.newWorkout.setDateValues(date: date)
        selectedWorkoutID = workoutsController.addWorkout(workout: workoutsController.newWorkout)
        newWorkoutAdded = true
        
        // Reset date and workout
        date = Date()
        workoutsController.newWorkout = WorkoutViewModel(workout: Workout.default)
    }
    
}


struct WorkoutView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutsPageView()
    }
}
