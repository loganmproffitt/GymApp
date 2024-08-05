import SwiftUI

struct WorkoutGroupsView: View {
    
    @ObservedObject var controller = WorkoutGroupsController.shared
    
    var body: some View {
        
        ForEach(controller.keys, id: \.self) { yearMonth in
            if let viewModel = controller.viewModels[yearMonth], !viewModel.workouts.isEmpty {
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
