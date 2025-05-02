import ComposableArchitecture

public struct AppFeature: Reducer {
    public struct State: Equatable {
        public var main: MainFeature.State
        
        public init(main: MainFeature.State = .init()) {
            self.main = main
        }
    }
    
    public enum Action: Equatable {
        case main(MainFeature.Action)
    }
    
    public init() {}
    
    public var body: some ReducerOf<Self> {
        Scope(state: \.main, action: /Action.main) {
            MainFeature()
        }
    }
} 