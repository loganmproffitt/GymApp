import Foundation
import RealmSwift

class RealmService {
    
    static let shared = RealmService()
    private var realm: Realm

    private init() {
        let config = Realm.Configuration(
            schemaVersion: 1, // Increment this whenever you make changes to your models
            deleteRealmIfMigrationNeeded: true
            /*
            migrationBlock: { migration, oldSchemaVersion in
                if oldSchemaVersion < 1 {
                    // Migration block
                    migration.enumerateObjects(ofType: Workout.className()) { oldObject, newObject in
                        
                    }
                }
                // Add more if statements as needed for future schema versions
            }*/
        )
        
        Realm.Configuration.defaultConfiguration = config
        
        do {
            realm = try Realm()
        } catch {
            fatalError("Error initializing Realm: \(error.localizedDescription)")
        }
    }
    
    func getRealm() -> Realm {
            return realm
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
