import SwiftUI
import RealmSwift

struct WorkoutsPageView: View {
    @ObservedObject var workoutsController = WorkoutGroupsController.shared
    @State private var selectedWorkoutID: ObjectId? = nil
    @State private var date = Date()
    @State var calendarVisible = false

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
                
                
                // Calendar
                if calendarVisible {
                    DatePicker(
                        "Workout Date",
                        selection: $date,
                        displayedComponents: [.date]
                    )
                    .datePickerStyle(.graphical)
                    .background(Color.gray)
                    .cornerRadius(10)
                    .shadow(radius: 10)
                    .padding()
                    .frame(maxWidth: 400, maxHeight: 400)
                    .position(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height * 2 / 3) // Position the calendar in the center top part of the screen
                    .transition(.slide)
                }

                
                // New workout buttons
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        
                        // Pick date button
                        Button(action: {
                            withAnimation {
                                calendarVisible.toggle()
                        }}) {
                                Image(systemName: "calendar.badge.plus")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 48, height: 48)
                                    .foregroundColor(.yellow)
                            .padding()
                        }
                        
                        // Add workout button (current date)
                        Button(action: {
                            withAnimation {
                                calendarVisible = false
                                selectedWorkoutID = workoutsController.addWorkout(providedDate: date)
                                date = Date()
                        }}) {
                                Image(systemName: "plus.circle.fill")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 48, height: 48)
                                    .foregroundColor(.blue)
                            .padding()
                        }
                        .padding(.trailing)
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
