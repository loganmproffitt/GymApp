import Foundation
import RealmSwift

class SetViewModel: ObservableObject {
    
    @Published var set: Set
    
    init(set: Set) {
        self.set = set
    }
    
    var weight: String {
        get {
            set.weight
        }
        set {
            RealmService.shared.update {
                self.set.weight = newValue
            }
        }
    }
    
    var reps: String {
        get {
            set.reps
        }
        set {
            RealmService.shared.update {
                self.set.reps = newValue
            }
        }
    }
}
