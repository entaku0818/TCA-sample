import SwiftUI
import ComposableArchitecture

public struct MainView: View {
    let store: StoreOf<MainFeature>
    
    public init(store: StoreOf<MainFeature>) {
        self.store = store
    }
    
    public var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            NavigationStack {
                VStack {
                    NavigationView(
                        store: store.scope(
                            state: \.navigation,
                            action: MainFeature.Action.navigation
                        )
                    )
                    
                    List {
                        ForEach(viewStore.items, id: \.self) { item in
                            Text(item)
                        }
                    }
                    
                    Button("すべてを見る") {
                        viewStore.send(.viewAllTapped)
                    }
                    .padding()
                }
                .navigationDestination(
                    store: store.scope(
                        state: \.detail,
                        action: MainFeature.Action.detail
                    )
                ) { detailStore in
                    DetailView(store: detailStore)
                }
            }
        }
    }
} 