import SwiftUI
import ComposableArchitecture

public struct NavigationView: View {
    @Bindable var store: StoreOf<NavigationFeature>
    
    public init(store: StoreOf<NavigationFeature>) {
        self.store = store
    }
    
    public var body: some View {
        if store.isEditing {
            HStack {
                TextField("タイトル", text: $store.title)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Button("保存") {
                    store.send(.view(.saveButtonTapped))
                }
                
                Button("キャンセル") {
                    store.send(.view(.cancelButtonTapped))
                }
            }
            .padding()
        } else {
            HStack {
                Text(store.title)
                    .font(.headline)
                
                Spacer()
                
                Button {
                    store.send(.view(.editButtonTapped))
                } label: {
                    Image(systemName: "pencil")
                }
            }
            .padding()
        }
    }
} 