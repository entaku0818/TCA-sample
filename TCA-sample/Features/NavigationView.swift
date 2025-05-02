import SwiftUI
import ComposableArchitecture

public struct NavigationView: View {
    @Bindable var store: StoreOf<NavigationFeature>
    
    public init(store: StoreOf<NavigationFeature>) {
        self.store = store
    }
    
    public var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            if viewStore.isEditing {
                HStack {
                    TextField("タイトル", text: viewStore.$title)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    Button("保存") {
                        viewStore.send(.view(.saveButtonTapped))
                    }
                    
                    Button("キャンセル") {
                        viewStore.send(.view(.cancelButtonTapped))
                    }
                }
                .padding()
            } else {
                HStack {
                    Text(viewStore.title)
                        .font(.headline)
                    
                    Spacer()
                    
                    Button {
                        viewStore.send(.view(.editButtonTapped))
                    } label: {
                        Image(systemName: "pencil")
                    }
                }
                .padding()
            }
        }
    }
} 