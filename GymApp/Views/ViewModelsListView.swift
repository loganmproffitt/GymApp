import SwiftUI

struct ViewModelsListView: View {
    
    @ObservedObject var controller = TimePeriodController.shared
    
    var body: some View {
    
        // Loop through view models
        ForEach(Array(controller.viewModels), id: \.key) { yearMonth, viewModel in
            VStack {
                // List workouts
                WorkoutsViewModelView(viewModel: viewModel)
            }
        }
    }
}

struct ViewModelListView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutsPageView()
    }
}
