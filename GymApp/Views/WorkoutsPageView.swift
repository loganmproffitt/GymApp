import SwiftUI
import RealmSwift

struct WorkoutsPageView: View {
    
    @ObservedObject var workoutsController = WorkoutGroupsController.shared
    
    @State private var selectedWorkoutID: ObjectId? = nil
    @State private var date = Date()
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
                                    Text("New Workout")
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                            }
                            .padding()
                        }
                    }
                    
                }
            }
        }
    }
    
    
    // Helper for adding workout
    private func addWorkout() {
        // Set date info and add workout, storing the new ID
        workoutsController.newWorkout.setDateValues(date: date)
        selectedWorkoutID = workoutsController.addWorkout(workout: workoutsController.newWorkout)
        
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
