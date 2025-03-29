import SwiftUI
import ComposableArchitecture

struct ContentView: View {
    var body: some View {
        TodoView(
            store: Store(
                initialState: TodoFeature.State(),
                reducer: { TodoFeature() }
            )
        )
    }
}

#Preview {
    ContentView()
}
