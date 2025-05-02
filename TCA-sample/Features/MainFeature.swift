import ComposableArchitecture

public struct MainFeature: Reducer {
    public struct State: Equatable {
        public var navigation: NavigationFeature.State
        public var items: [String]
        
        public init(
            navigation: NavigationFeature.State = .init(),
            items: [String] = ["Item 1", "Item 2", "Item 3"]
        ) {
            self.navigation = navigation
            self.items = items
        }
    }
    
    public enum Action: Equatable {
        case navigation(NavigationFeature.Action)
        case viewAllTapped
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
                return .none
            }
        }
    }
} 