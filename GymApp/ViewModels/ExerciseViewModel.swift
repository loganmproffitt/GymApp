import Foundation
import RealmSwift

class ExerciseViewModel: ObservableObject, Identifiable {
    
    @Published private var _name: String
    @Published private var _completed: Bool
    @Published private var _notes: String
    @Published private var _setCountModified: Bool
    @Published private var _setCount: String
    @Published private var _sets: List<Set>
    
    @Published var exercise: Exercise
    
    init(exercise: Exercise) {
        self.exercise = exercise
        self._name = exercise.name
        self._completed = exercise.completed
        self._notes = exercise.notes
        self._setCountModified = exercise.setCountModified
        self._setCount = exercise.setCount
        self._sets = exercise.sets
    }
    
    var id: ObjectId {
        exercise.id
    }
    
    var name: String {
        get {
            _name
        }
        set {
            _name = newValue
            RealmService.shared.update {
                self.exercise.name = newValue
            }
        }
    }
    
    var completed: Bool {
        get {
            _completed
        }
        set {
            _completed = newValue
            RealmService.shared.update {
                self.exercise.completed = newValue
            }
        }
    }
    
    var notes: String {
        get {
            _notes
        }
        set {
            _notes = newValue
            RealmService.shared.update {
                self.exercise.notes = newValue
            }
        }
    }
    
    var setCountModified: Bool {
        get {
            _setCountModified
        }
        set {
            _setCountModified = newValue
            RealmService.shared.update {
                self.exercise.setCountModified = newValue
            }
        }
    }
    
    var setCount: String {
        get {
            _setCount
        }
        set {
            _setCount = newValue
            RealmService.shared.update {
                self.exercise.setCount = newValue
            }
        }
    }
    
    var sets: List<Set> {
        get {
            _sets
        }
        set {
            _sets = newValue
            RealmService.shared.update {
                self.exercise.sets.removeAll()
                self.exercise.sets.append(objectsIn: newValue)
            }
        }
    }
    
    // Toggle checkbox helper
    func toggleCheckbox() {
        let newState = !_completed
        _completed = newState
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
        _sets = exercise.sets
    }
    
    // Remove set helper
    func deleteSet(at index: Int) {
        RealmService.shared.update {
            guard index < self.sets.count else { return }
            self.exercise.sets.remove(at: index)
        }
        _sets = exercise.sets
    }
}
