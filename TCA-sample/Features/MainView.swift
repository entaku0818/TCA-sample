import SwiftUI
import ComposableArchitecture

public struct MainView: View {
    let store: StoreOf<MainFeature>
    
    public init(store: StoreOf<MainFeature>) {
        self.store = store
    }
    
    public var body: some View {
        NavigationStack {
            VStack {
                NavigationView(
                    store: store.scope(
                        state: \.navigation,
                        action: MainFeature.Action.navigation
                    )
                )
                
                List {
                    ForEach(store.items, id: \.self) { item in
                        Text(item)
                    }
                }
                
                Button("すべてを見る") {
                    store.send(.view(.viewAllTapped))
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