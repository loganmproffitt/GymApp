import Foundation

struct Notes: Identifiable, Codable {
    var id = UUID()
    var notes: String
    var bodyWeight: Float
}
