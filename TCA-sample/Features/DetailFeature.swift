import ComposableArchitecture
import SwiftUI

@Reducer
public struct DetailFeature {
    @ObservableState
    public struct State: Equatable {
        public var items: [String]
        public var title: String
        
        public init(items: [String], title: String = "詳細") {
            self.items = items
            self.title = title
        }
    }
    
    @ViewAction(for: DetailFeature.self)
    public enum Action: ViewAction, BindableAction, Sendable {
        case binding(BindingAction<State>)
        case view(View)
        case dismiss
        
        public enum View: Equatable {
            case itemTapped(String)
        }
    }
    
    public init() {}
    
    public var body: some ReducerOf<Self> {
        BindingReducer()
        
        Reduce { state, action in
            switch action {
            case .binding:
                return .none
                
            case .view(.itemTapped):
                return .none
                
            case .dismiss:
                return .none
            }
        }
    }
} 