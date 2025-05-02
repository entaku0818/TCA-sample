import SwiftUI
import ComposableArchitecture

public struct DetailView: View {
    let store: StoreOf<DetailFeature>
    
    public init(store: StoreOf<DetailFeature>) {
        self.store = store
    }
    
    public var body: some View {
        List {
            ForEach(store.items, id: \.self) { item in
                Button {
                    store.send(.view(.itemTapped(item)))
                } label: {
                    Text(item)
                }
            }
        }
        .navigationTitle(store.title)
    }
} 