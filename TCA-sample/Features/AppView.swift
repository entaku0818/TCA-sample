import SwiftUI
import ComposableArchitecture

struct AppView: View {
    @Bindable var store: StoreOf<AppFeature>
    
    init(store: StoreOf<AppFeature>) {
        self.store = store
    }
    
    var body: some View {
        MainView(
            store: store.scope(
                state: \.main,
                action: AppFeature.Action.main
            )
        )
    }
} 
