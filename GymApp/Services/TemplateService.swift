import Foundation
import RealmSwift

class TemplateService {
    
    // Load all templates in the database
    func loadTemplates() -> [Workout] {
        let realm = RealmService.shared.getRealm()
        let templates = Array(realm.objects(Workout.self).filter("isTemplate == true"))
        return templates
    }
}
