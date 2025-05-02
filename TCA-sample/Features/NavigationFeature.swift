import ComposableArchitecture

public struct NavigationFeature: Reducer {
    public struct State: Equatable {
        public var title: String
        
        public init(title: String = "Navigation") {
            self.title = title
        }
    }
    
    public enum Action: Equatable {
        case titleChanged(String)
    }
    
    public init() {}
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case let .titleChanged(newTitle):
                state.title = newTitle
                return .none
            }
        }
    }
} 