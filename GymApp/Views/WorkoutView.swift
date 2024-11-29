import SwiftUI

struct WorkoutView: View {
    
    @EnvironmentObject var workoutViewModel: WorkoutViewModel
    @State private var showCalendar = false
    @State private var navigationPath = NavigationPath([String]())

    var body: some View {
        NavigationStack() {
            ZStack {
                
                // Exercise vertical stack
                VStack(spacing: 0) {
                    HStack {
                        // Date text
                        Text(DateService.getStringDate(for: workoutViewModel.rawDate))
                            .font(.title)
                            .bold()
                            .padding([.top, .leading, .trailing])
                            .foregroundColor(.yellow)
                            .minimumScaleFactor(0.7)
                        
                        Spacer()
                    }
                    
                    if showCalendar {
                        DatePicker(
                            "",
                            selection: $workoutViewModel.rawDate,
                            displayedComponents: [.date]
                        )
                        .datePickerStyle(.graphical) // Graphical calendar for inline display
                        .padding(.leading)
                        Button(action: { withAnimation { showCalendar.toggle() }}) {
                            Text("Done")
                                .foregroundColor(.blue)
                                .padding()
                        }
                    }
                    
                    // Exercises list
                    List {
                        
                        Section(header: // Workout name
                                TextField(workoutViewModel.name, text: $workoutViewModel.name)
                            .font(.title2)
                            .bold()
                            .padding([.trailing])
                            .minimumScaleFactor(0.5)
                            .textCase(nil)
                        ){
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
                    .listStyle(.insetGrouped)
                    
                    Spacer()
                    
                }
                .toolbar {
                    
                    // Top tool bar
                    ToolbarItem(placement: .navigationBarTrailing) {
                        HStack {
                            Spacer()
                            
                            // Calendar button
                            Button(action: {
                                withAnimation {
                                    showCalendar.toggle()
                                }
                            }) {
                                Image(systemName: "calendar")
                                    .font(.title3)
                                    .foregroundColor(.blue)
                            }
                            
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
                            NavigationLink(destination: TemplatesView(dismiss: true, onTemplateSelected: {
                            })
                            .environmentObject(workoutViewModel))
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
                        } label: {
                            HStack {
                                Image(systemName: "folder")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 30, height: 30)
                                    .foregroundColor(.blue)
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
}

struct WorkoutDetailView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutsPageView()
    }
}
