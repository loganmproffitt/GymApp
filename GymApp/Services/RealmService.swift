import Foundation
import RealmSwift

class RealmService {
    
    static let shared = RealmService()
    private var realm: Realm
    
    private init() {
        realm = try! Realm()
    }
    
    // Write function
    func write(_ block: @escaping () -> Void) {
        do {
            try realm.write {
                block()
            }
        } catch {
            print("Error writing to Realm: \(error.localizedDescription)")
        }
    }
    
    // Add helper
    func add<T: Object>(_ object: T) {
        write {
            self.realm.add(object)
        }
    }
    
    // Delete helper
    func delete<T: Object>(_ object: T) {
        write {
            self.realm.delete(object)
        }
    }
    
    // Update helper
    func update(_ block: @escaping () -> Void) {
        write(block)
    }
    
    // Filter helper
    func fetch<T: Object>(_ objectType: T.Type, filter: String) -> Results<T> {
        return realm.objects(objectType).filter(filter)
    }
}
