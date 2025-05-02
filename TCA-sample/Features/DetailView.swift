import SwiftUI
import ComposableArchitecture

@ViewAction(for: DetailFeature.self)
struct DetailView: View {
    @Bindable var store: StoreOf<DetailFeature>
    
    init(store: StoreOf<DetailFeature>) {
        self.store = store
    }
    
    var body: some View {
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
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button("閉じる") {
                    store.send(.view(.dismissButtonTapped))
                }
            }
        }
    }
} 
