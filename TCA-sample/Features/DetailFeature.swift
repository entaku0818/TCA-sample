import ComposableArchitecture

public struct DetailFeature: Reducer {
    public struct State: Equatable {
        public var items: [String]
        public var title: String
        
        public init(items: [String], title: String = "詳細") {
            self.items = items
            self.title = title
        }
    }
    
    public enum Action: Equatable {
        case itemTapped(String)
    }
    
    public init() {}
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .itemTapped:
                return .none
            }
        }
    }
} 