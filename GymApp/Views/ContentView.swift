import SwiftUI

struct ContentView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        VStack {
            Picker("Tabs", selection: $selectedTab) {
                Text("Workout").tag(0)
                Text("Macros").tag(1)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding([.top, .leading, .trailing])
            .contentShape(Rectangle())

            TabView(selection: $selectedTab) {
                WorkoutsPageView()
                    .tag(0)

                MacroView()
                    .tag(1)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

