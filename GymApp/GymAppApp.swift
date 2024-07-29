import SwiftUI

@main
struct GymAppApp: App {
    
    @StateObject private var workoutsViewModel = WorkoutsViewModel()
    
    init() {
        loadData()
    }
    
    private func loadData() {
        WorkoutGroupsController.shared.loadAllWorkouts()
    }
    
    var body: some Scene {
        WindowGroup {
            WorkoutsPageView()
        }
    }
    
    

}
