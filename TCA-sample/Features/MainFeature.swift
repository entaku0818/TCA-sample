import ComposableArchitecture
import SwiftUI

@Reducer
struct MainFeature {
    @ObservableState
    struct State: Equatable {
        var navigation: NavigationFeature.State
        var lists: [ListSection]
        @Presents var detail: DetailFeature.State?
        
        struct ListSection: Equatable, Identifiable {
            let id: String
            let title: String
            let items: [String]
            
            init(id: String, title: String, items: [String]) {
                self.id = id
                self.title = title
                self.items = items
            }
        }
        
        init(
            navigation: NavigationFeature.State = .init(),
            lists: [ListSection] = [
                ListSection(id: "1", title: "アクション", items: ["アイテム1", "アイテム2", "アイテム3"]),
                ListSection(id: "2", title: "コメディ", items: ["アイテム4", "アイテム5", "アイテム6"]),
                ListSection(id: "3", title: "ドラマ", items: ["アイテム7", "アイテム8", "アイテム9"])
            ],
            detail: DetailFeature.State? = nil
        ) {
            self.navigation = navigation
            self.lists = lists
            self.detail = detail
        }
    }
    
    enum Action: ViewAction, BindableAction, Sendable {
        case binding(BindingAction<State>)
        case view(View)
        case navigation(NavigationFeature.Action)
        case detail(PresentationAction<DetailFeature.Action>)
        
        enum View: Equatable, Sendable {
            case viewAllTapped(String)
        }
    }
    
    init() {}
    
    var body: some ReducerOf<Self> {
        BindingReducer()
        
        Scope(state: \.navigation, action: \.navigation) {
            NavigationFeature()
        }
        
        Reduce { state, action in
            switch action {
            case .binding:
                return .none
                
            case .navigation:
                return .none
                
            case let .view(.viewAllTapped(listId)):
                if let list = state.lists.first(where: { $0.id == listId }) {
                    state.detail = .init(
                        items: list.items,
                        title: list.title
                    )
                }
                return .none
                
            case .detail:
                return .none
            }
        }
        .ifLet(\.$detail, action: \.detail) {
            DetailFeature()
        }
    }
} 
