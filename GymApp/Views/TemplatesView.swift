import Foundation
import SwiftUI

struct TemplatesView: View {
    
    @ObservedObject var controller = TemplateController.shared
    @EnvironmentObject var workoutViewModel: WorkoutViewModel
    
    var onTemplateSelected: () -> Void
    
    var body: some View {
        List {
            // Title
            Section(header: Text("Templates")
                .font(.headline)
                .padding(.top, 10)
                .padding(.bottom, 5)) {
                    
                // Display templates
                ForEach(controller.templates.indices, id: \.self) { index in
                    Button(action: {
                        controller.copyTemplate(at: index, to: workoutViewModel)
                        onTemplateSelected()
                    }) {
                        HStack {
                            Text(controller.templates[index].name)
                            Spacer()
                        }
                        .padding()
                    }
                }
                .onDelete { indexSet in
                    withAnimation {
                        if let index = indexSet.first {
                            controller.deleteTemplate(at: index)
                        }
                    }
                }
            }
        }
        .buttonStyle(BorderlessButtonStyle())
    }
}
