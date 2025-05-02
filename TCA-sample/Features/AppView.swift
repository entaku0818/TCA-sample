import SwiftUI
import ComposableArchitecture

public struct AppView: View {
    @Bindable var store: StoreOf<AppFeature>
    
    public init(store: StoreOf<AppFeature>) {
        self.store = store
    }
    
    public var body: some View {
        MainView(
            store: store.scope(
                state: \.main,
                action: AppFeature.Action.main
            )
        )
    }
} 