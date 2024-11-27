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
                        .padding(.leading)
                    
                }
            
                
                // Exercises list
                List {
                    Section(header: Text("Exercises").font(.caption).foregroundColor(.gray)) {
                        
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
                }
                .scrollDismissesKeyboard(.interactively)
             
            }
            .toolbar {
                
                // Top tool bar
                ToolbarItem(placement: .navigationBarTrailing) {
                    
                    // Calendar picker
                    DatePicker(
                        "",
                        selection: $workoutViewModel.rawDate,
                        displayedComponents: [.date]
                    )
                    .datePickerStyle(.compact)
                    .labelsHidden()
                    .background(Color.clear)
                    .cornerRadius(10)
                    .shadow(radius: 10)
                    .transition(.slide)
                    .padding(.trailing)
                    
                }
                
                // Bottom tool bar
                ToolbarItemGroup(placement: .bottomBar) {
                    Spacer()
                    
                    // Template menu
                    Menu {
                        Button(action: { showTemplates.toggle() }) {
                            Label("Load Template", systemImage: "folder")
                        }
                        Button(action: { TemplateController.shared.addTemplate(workout: workoutViewModel)} ) {
                            Label("Save Template", systemImage: "square.and.arrow.down")
                        }
                    } label: {
                        Image(systemName: "folder")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 36, height: 36)
                            .foregroundColor(.yellow)
                            .padding()
                    }
                    
                    // Add exercise button
                    Button(action: {
                        withAnimation {
                            workoutViewModel.addExercise()
                        }
                    }) {
                        Image(systemName: "plus.circle")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 48, height: 48)
                            .foregroundColor(.blue)
                    }
                    .padding()
                    
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

struct WorkoutDetailView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutsPageView()
    }
}
