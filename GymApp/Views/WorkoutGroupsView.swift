import SwiftUI

struct WorkoutGroupsView: View {
    
    @ObservedObject var controller = WorkoutGroupsController.shared
    
    var body: some View {
            ForEach(Array(controller.viewModels.keys), id: \.self) { yearMonth in
                if let viewModel = controller.viewModels[yearMonth] {
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
