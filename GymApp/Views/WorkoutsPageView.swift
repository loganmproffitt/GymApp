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
                
                VStack(spacing: 5) {
                    
                    // Top bar
                    HStack {
                        // Workouts text
                        Text("Workouts")
                            .font(.title)
                            .bold()
                            .padding(.leading)
                        
                        Spacer()
                        
                    }
                    .padding(.top) // Add padding at the top
                    
                    // List view models
                    List {
                        WorkoutGroupsView()
                    }
                    .scrollDismissesKeyboard(.interactively)
                    
                    Spacer()
                    
                    // Buttons
                    HStack {
                        
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
                        
                        
                        // Load templates button
                        Menu {
                            Button(action: { showTemplates.toggle() }) {
                                Label("Load Template", systemImage: "folder")
                            }
                        } label: {
                            Image(systemName: "folder")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 36, height: 36)
                                .foregroundColor(.yellow)
                                .padding()
                        }
                        
                        // Add workout button
                        Button(action: {
                            withAnimation {
                                workoutsController.newWorkout.name = workoutsController.newWorkout.weekDay
                                addWorkout()
                            }}) {
                                Image(systemName: "plus.circle.fill")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 40, height: 40)
                                    .foregroundColor(.blue)
                                    .padding(.trailing)
                            }
                        
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
