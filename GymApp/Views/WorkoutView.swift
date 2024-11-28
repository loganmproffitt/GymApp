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
                        Button(action: { showTemplates.toggle() }) {
                            Label("Load Template", systemImage: "folder")
                        }
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
                            }
                        })
                        .environmentObject(workoutViewModel)
                        //.padding()
                        .cornerRadius(10)
                        .shadow(radius: 10)
                        
                }
                .frame(width: 300, height: 400)
                //.padding()
           }
            
        }
    }
}

struct WorkoutDetailView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutsPageView()
    }
}
