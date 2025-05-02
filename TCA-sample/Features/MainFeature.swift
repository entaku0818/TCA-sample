import ComposableArchitecture

public struct MainFeature: Reducer {
    public struct State: Equatable {
        public var navigation: NavigationFeature.State
        public var items: [String]
        public var detail: DetailFeature.State?
        
        public init(
            navigation: NavigationFeature.State = .init(),
            items: [String] = ["Item 1", "Item 2", "Item 3"],
            detail: DetailFeature.State? = nil
        ) {
            self.navigation = navigation
            self.items = items
            self.detail = detail
        }
    }
    
    public enum Action: Equatable {
        case navigation(NavigationFeature.Action)
        case viewAllTapped
        case detail(DetailFeature.Action)
        case detailDismissed
    }
    
    public init() {}
    
    public var body: some ReducerOf<Self> {
        Scope(state: \.navigation, action: /Action.navigation) {
            NavigationFeature()
        }
        
        Reduce { state, action in
            switch action {
            case .navigation:
                return .none
            case .viewAllTapped:
                state.detail = DetailFeature.State(items: state.items)
                return .none
            case .detail:
                return .none
            case .detailDismissed:
                state.detail = nil
                return .none
            }
        }
        .ifLet(\.detail, action: /Action.detail) {
            DetailFeature()
        }
    }
} 