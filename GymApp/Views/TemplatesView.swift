import Foundation
import SwiftUI

struct TemplatesView: View {
    
    @ObservedObject var controller = TemplateController.shared
    @EnvironmentObject var workoutViewModel: WorkoutViewModel
    
    var dismiss: Bool
    
    var onTemplateSelected: () -> Void
    
    @Environment(\.presentationMode) private var presentationMode
    
    var body: some View {
        List {
            // Title
            Section(header: Text("Templates")
                .font(.title)
                .bold()
                .foregroundColor(.yellow)
            ){
                    
                // Display templates
                ForEach(controller.templates.indices, id: \.self) { index in
                    Button(action: {
                        controller.copyTemplate(at: index, to: workoutViewModel)
                        onTemplateSelected()
                        if dismiss {
                            presentationMode.wrappedValue.dismiss()
                        }
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
