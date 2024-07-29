import SwiftUI

@main
struct GymAppApp: App {
    
    @StateObject private var workoutsViewModel = WorkoutListViewModel()
    
    init() {
        loadData()
    }
    
    private func loadData() {
        WorkoutGroupsController.shared.loadMonth(yearMonth: DateService.getYearMonth(for: Date()))
    }
    
    var body: some Scene {
        WindowGroup {
            WorkoutsPageView()
        }
    }
    
    

}
