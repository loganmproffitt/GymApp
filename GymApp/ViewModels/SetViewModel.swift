import Foundation
import RealmSwift

class SetViewModel: ObservableObject {
    
    @Published var set: Set
    
    @Published var _weight: String
    @Published var _reps: String
    
    init(set: Set) {
        self.set = set
        _weight = set.weight
        _reps = set.reps
    }
    
    var weight: String {
        get {
            _weight
        }
        set {
            _weight = newValue
            RealmService.shared.update {
                self.set.weight = newValue
            }
        }
    }
    
    var reps: String {
        get {
            _reps
        }
        set {
            _reps = newValue
            RealmService.shared.update {
                self.set.reps = newValue
            }
        }
    }
}
