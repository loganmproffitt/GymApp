import Foundation
import RealmSwift

class ExerciseViewModel: ObservableObject, Identifiable {
    
    @Published var exercise: Exercise
    
    init(exercise: Exercise) {
        self.exercise = exercise
    }
    
    var id: ObjectId {
        exercise.id
    }
    
    var name: String {
        get {
            exercise.name
        }
        set {
            RealmService.shared.update {
                self.exercise.name = newValue
            }
        }
    }
    
    var completed: Bool {
        get {
            exercise.completed
        }
        set {
            RealmService.shared.update {
                self.exercise.completed = newValue
            }
        }
    }
    
    var notes: String {
        get {
            exercise.notes
        }
        set {
            RealmService.shared.update {
                self.exercise.notes = newValue
            }
        }
    }
    
    var setCountModified: Bool {
        get {
            exercise.setCountModified
        }
        set {
            RealmService.shared.update {
                self.exercise.setCountModified = newValue
            }
        }
    }
    
    var setCount: String {
        get {
            exercise.setCount
        }
        set {
            RealmService.shared.update {
                self.exercise.setCount = newValue
            }
        }
    }
    
    var sets: List<Set> {
        get {
            exercise.sets
        }
        set {
            RealmService.shared.update {
                self.exercise.sets.removeAll()
                self.exercise.sets.append(objectsIn: newValue)
            }
            objectWillChange.send()
        }
    }
    
    // Toggle checkbox helper
    func toggleCheckbox() {
        let newState = !exercise.completed
        RealmService.shared.update {
            self.exercise.completed = newState
        }
    }
    
    // Add set helper
    func addSet() {
        let newSet = Set.default
        RealmService.shared.update {
            self.exercise.sets.append(newSet)
        }
        objectWillChange.send()
    }
    
    // Remove set helper
    func deleteSet(at index: Int) {
        RealmService.shared.update {
            guard index < self.sets.count else { return }
            self.exercise.sets.remove(at: index)
        }
        objectWillChange.send()
    }
}
