import SwiftUI
import RealmSwift

struct WorkoutsPageView: View {
    
    @ObservedObject var workoutsController = WorkoutGroupsController.shared
    
    @State private var selectedWorkoutID: ObjectId? = nil
    @State private var date = Date()
    @State private var newWorkoutAdded = false
    @State private var showTemplates = false

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
    
                            HStack {
                                Image(systemName: "folder")
                                    .foregroundColor(.blue)
                                    .frame(width: 30, height: 30)
                                Text("Load Template")
                                    .foregroundColor(.blue)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .onTapGesture {
                                showTemplates = true
                            }
                            
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
            // Templates page
            .navigationDestination(isPresented: $showTemplates) {
                TemplatesView(dismiss: false, onTemplateSelected: {
                        withAnimation {
                            addWorkout()
                            showTemplates = false
                        }
                    })
                    .environmentObject(workoutsController.newWorkout)
                }
            // Move to new workout or template
            .navigationDestination(isPresented: $newWorkoutAdded) {
                if let workoutID = selectedWorkoutID,
                   let workoutIndex = workoutsController
                       .getWorkoutListViewModel(for: date)
                       .getWorkoutIndex(for: workoutID),
                   workoutIndex >= 0,
                   workoutIndex < workoutsController.getWorkoutListViewModel(for: date).workouts.count
                {
                    let workout = workoutsController
                        .getWorkoutListViewModel(for: date)
                        .workouts[workoutIndex]

                    WorkoutView()
                        .environmentObject(workout)
                } else {
                    Text("Workout not found.")
                }
            }
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
