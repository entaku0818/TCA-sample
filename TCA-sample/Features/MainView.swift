import SwiftUI
import ComposableArchitecture

@ViewAction(for: MainFeature.self)
struct MainView: View {
    @Bindable var store: StoreOf<MainFeature>
    
    init(store: StoreOf<MainFeature>) {
        self.store = store
    }
    
    var body: some View {
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
                                    send(.viewAllTapped(list.id))
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
} 
