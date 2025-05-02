import SwiftUI
import ComposableArchitecture

public struct NavigationView: View {
    let store: StoreOf<NavigationFeature>
    
    public init(store: StoreOf<NavigationFeature>) {
        self.store = store
    }
    
    public var body: some View {
        Text(store.title)
            .font(.headline)
            .padding()
    }
} 