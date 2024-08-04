import Foundation
import RealmSwift

class TemplateController: ObservableObject {
    
    static let shared = TemplateController()
    
    @Published var templates: [WorkoutViewModel]
    
    init() {
        self.templates = []
    }
    
    func loadTemplates() {
        // Get models
        let templateModels = TemplateService().loadTemplates()
        // Convert to view models
        templates = getViewModels(models: templateModels)
        print(templates)
    }
    
    func addTemplate(workout: WorkoutViewModel) {
        // Create copy with template
        let template = Workout(name: workout.name, rawDate: workout.rawDate, notes: workout.notes, isTemplate: true, exercises: Array(workout.exercises))
        
        // Save to realm
        RealmService.shared.add(template)
        
        // Add to published array
        templates.append(WorkoutViewModel(workout: template))
        print(templates)
    }
    
    func deleteTemplate(at index: Int) {
        print("Delete clicked")
        guard index < self.templates.count else { return }
        let templateViewModel = self.templates[index]
        print("Deleting template")
        
        // Remove from Realm
        RealmService.shared.delete(templateViewModel.workout)
        
        // Remove from local list
        self.templates.remove(at: index)
    }
    
    func copyTemplate(at index: Int, to workoutViewModel: WorkoutViewModel) {
        guard index < templates.count else { return }
        let template = templates[index]
        // Copy data
        workoutViewModel.name = template.name
        workoutViewModel.exercises = template.exercises
        workoutViewModel.notes = template.notes
        workoutViewModel.isTemplate = false
    }
    
    // Wrap models in view models
    func getViewModels(models: [Workout]) -> [WorkoutViewModel] {
        var viewModels: [WorkoutViewModel] = []
        for model in models {
            viewModels.append(WorkoutViewModel(workout: model))
        }
        return viewModels
    }
}
