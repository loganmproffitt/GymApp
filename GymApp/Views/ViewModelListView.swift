import SwiftUI

struct ViewModelListView: View {
    
    @ObservedObject var controller = WorkoutListController.shared
    
    var body: some View {
    
        // Loop through view models
        ForEach(Array(controller.viewModels), id: \.key) { yearMonth, viewModel in
            VStack {
                // List workouts
                WorkoutListView(viewModel: viewModel)
            }
        }
    }
}

struct ViewModelListView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutsPageView()
    }
}
