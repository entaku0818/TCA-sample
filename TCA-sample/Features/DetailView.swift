import SwiftUI
import ComposableArchitecture

public struct DetailView: View {
    let store: StoreOf<DetailFeature>
    
    public init(store: StoreOf<DetailFeature>) {
        self.store = store
    }
    
    public var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            List {
                ForEach(viewStore.items, id: \.self) { item in
                    Button {
                        viewStore.send(.itemTapped(item))
                    } label: {
                        Text(item)
                    }
                }
            }
            .navigationTitle(viewStore.title)
        }
    }
} 