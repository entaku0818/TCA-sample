import ComposableArchitecture
import SwiftUI

@Reducer
public struct NavigationFeature {
    @ObservableState
    public struct State: Equatable {
        public var title: String
        
        public init(title: String = "Navigation") {
            self.title = title
        }
    }
    
    public enum Action: ViewAction, BindableAction, Sendable {
        case binding(BindingAction<State>)
        case view(View)
        
        public enum View: Equatable, Sendable {
            case titleChanged(String)
        }
    }
    
    public init() {}
    
    public var body: some ReducerOf<Self> {
        BindingReducer()
        
        Reduce { state, action in
            switch action {
            case .binding:
                return .none
                
            case let .view(.titleChanged(newTitle)):
                state.title = newTitle
                return .none
            }
        }
    }
} 
