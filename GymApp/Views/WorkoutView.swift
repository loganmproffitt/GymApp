import SwiftUI

struct WorkoutView: View {
    
    @EnvironmentObject var workoutViewModel: WorkoutViewModel
    @State var showTemplates = false

    var body: some View {
        ZStack {
            // Exercise vertical stack
            VStack() {
                
                // Workout name
                HStack {
                    // Workout name
                    TextField(workoutViewModel.name, text: $workoutViewModel.name)
                        .font(.title)
                        .padding([.top, .leading, .trailing])
                        .minimumScaleFactor(0.5)
                
                    Spacer()
                }
                
                // Exercises list
                List {
                        // List exercises
                        ForEach(workoutViewModel.exercises.indices, id: \.self) { index in
                            ExerciseCardView(
                                exerciseViewModel: ExerciseViewModel(exercise: workoutViewModel.exercises[index]))
                        }
                        .onDelete { indexSet in
                            if let index = indexSet.first {
                                withAnimation {
                                    workoutViewModel.removeExercise(at: index)
                                }
                            }
                        
                    }
                }
                .scrollDismissesKeyboard(.interactively)
                .padding(0)
                
                Spacer()
             
            }
            .toolbar {
                
                // Top tool bar
                ToolbarItem(placement: .navigationBarTrailing) {
                    HStack {
                        Spacer()
                        // Calendar picker
                        DatePicker(
                            "",
                            selection: $workoutViewModel.rawDate,
                            displayedComponents: [.date]
                        )
                        .datePickerStyle(.compact)
                        //.labelsHidden()
                        .background(Color.clear)
                        .cornerRadius(10)
                        .shadow(radius: 10)
                        .transition(.slide)
                    }
                }
                
                // Bottom tool bar
                ToolbarItemGroup(placement: .bottomBar) {
  
                    // Template menu
                    Menu {
                        Button(action: { TemplateController.shared.addTemplate(workout: workoutViewModel)} ) {
                            Label("Save as Template", systemImage: "square.and.arrow.down")
                        }
                        
                        // Templates view
                        NavigationLink(destination: TemplatesView(onTemplateSelected: {
                        })
                        .environmentObject(workoutViewModel))
                        {
                            HStack {
                                Image(systemName: "folder")
                                    .foregroundColor(.yellow)
                                Text("Load Template")
                                    .foregroundColor(.yellow)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        .padding()
                        
                    } label: {
                        HStack {
                            Image(systemName: "folder")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 30, height: 30)
                                .foregroundColor(.yellow)
                        }
                    }
                    
                    Spacer()
                    
                    // Add exercise button
                    Button(action: {
                        withAnimation {
                            workoutViewModel.addExercise()
                        }
                    }) {
                        HStack {
                            Image(systemName: "plus.circle")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 30, height: 30)
                                .foregroundColor(.blue)
                            Text("Add Exercise")
                                .foregroundColor(.blue)
                            
                        }
                    }
                }
            }
        }
    }
}

struct WorkoutDetailView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutsPageView()
    }
}
