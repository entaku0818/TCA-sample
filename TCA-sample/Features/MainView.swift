import SwiftUI
import ComposableArchitecture

public struct MainView: View {
    let store: StoreOf<MainFeature>
    
    public init(store: StoreOf<MainFeature>) {
        self.store = store
    }
    
    public var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    NavigationView(
                        store: store.scope(
                            state: \.navigation,
                            action: \.navigation
                        )
                    )
                    
                    ForEach(store.lists) { list in
                        VStack(alignment: .leading) {
                            HStack {
                                Text(list.title)
                                    .font(.title2)
                                    .fontWeight(.bold)
                                
                                Spacer()
                                
                                Button("すべてを見る") {
                                    store.send(.view(.viewAllTapped(list.id)))
                                }
                                .font(.subheadline)
                            }
                            .padding(.horizontal)
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 10) {
                                    ForEach(list.items, id: \.self) { item in
                                        Text(item)
                                            .frame(width: 120, height: 180)
                                            .background(Color.gray.opacity(0.2))
                                            .cornerRadius(8)
                                    }
                                }
                                .padding(.horizontal)
                            }
                        }
                    }
                }
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