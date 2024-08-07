import SwiftUI

@main
struct GymAppApp: App {
    
    @StateObject private var workoutsViewModel = WorkoutListViewModel()
    
    init() {
        loadData()
    }
    
    private func loadData() {
        WorkoutGroupsController.shared.loadAllMonths()
        TemplateController.shared.loadTemplates()
    }
    
    var body: some Scene {
        WindowGroup {
            WorkoutsPageView()
        }
    }
    
    

}
