import SwiftUI

struct WorkoutView: View {
    
    @EnvironmentObject var workoutViewModel: WorkoutViewModel
    @State var showTemplates = false

    var body: some View {
        ZStack {
            // Exercise vertical stack
            VStack(spacing: -5) {
                
                // Workout name and date
                HStack {
                    TextField(workoutViewModel.name, text: $workoutViewModel.name)
                        .font(.title)
                        .padding(.leading)
                        .onChange(of: workoutViewModel.name) { oldValue, newValue in
                            //workoutViewModel.name = newValue
                        }
                    Spacer() // Pushes the TextField to the left
                    
                    Text(workoutViewModel.formattedDate)
                        .font(.caption)
                        .foregroundColor(.gray)
                        .padding(.trailing)
                }
                .padding(.top) // Add padding at the top
                
                
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
                
                Spacer()
                
                // Tool bar
                HStack {
                    
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
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 36, height: 36)
                            .foregroundColor(.blue)
                            .padding()
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
