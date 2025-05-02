import SwiftUI
import ComposableArchitecture

struct ContentView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            TodoView(
                store: Store(
                    initialState: TodoFeature.State(),
                    reducer: { TodoFeature() }
                )
            )
            .tabItem {
                Label("Todo", systemImage: "checklist")
            }
            .tag(0)
            
            AppView(
                store: Store(
                    initialState: AppFeature.State(),
                    reducer: { AppFeature() }
                )
            )
            .tabItem {
                Label("Main", systemImage: "list.bullet")
            }
            .tag(1)
        }
    }
}

#Preview {
    ContentView()
}
