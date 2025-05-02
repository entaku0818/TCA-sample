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
                        action: \.navigation
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
        }
        .navigationDestination(
            store: store.scope(
                state: \.$detail,
                action: \.detail
            )
        ) { store in
            DetailView(store: store)
        }
    }
} 