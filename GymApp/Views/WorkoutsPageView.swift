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
                        
                        
                        // New workout menu
                        Menu {
                            
                            // From templates
                            Button(action: { showTemplates.toggle() }) {
                                Label("Load From Template", systemImage: "folder")
                            }
                            
                            // Empty workout button
                            Button(action: {
                                withAnimation {
                                    workoutsController.newWorkout.name = DateService.getWeekday(for: date)
                                    addWorkout()
                                }}) {
                                    Label("New workout", systemImage: "plus.circle.fill")
                                }
                            
                        }
                    label: {
                        Image(systemName: "plus.circle")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 48, height: 48)
                            .foregroundColor(.blue)
                    }
                    .padding([.trailing, .leading])
                    }
                    
                }
                
                
                // Templates overlay
                if showTemplates {
                   Color.black.opacity(0.2)
                        .ignoresSafeArea()
                        .onTapGesture {
                            withAnimation {
                                showTemplates = false
                            }
                        }
                    
                    VStack {
                        TemplatesView(onTemplateSelected: {
                                withAnimation {
                                    showTemplates = false
                                    addWorkout()
                                }
                            })
                        .environmentObject(workoutsController.newWorkout)
                            .padding()
                            .cornerRadius(10)
                            .shadow(radius: 10)
                            
                    }
                    .frame(width: 300, height: 400)
                    .padding()
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
