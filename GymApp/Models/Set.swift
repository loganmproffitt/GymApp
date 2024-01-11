import Foundation

struct Set: Identifiable, Codable {
    var id = UUID()
    var weight: String
    var reps: String
    
    static var `default`: Set {
            Set(weight: "", reps: "")
    }
    
    init(weight: String, reps: String) {
            self.weight = weight
            self.reps = reps
    }
}
