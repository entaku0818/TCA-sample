import ComposableArchitecture
import SwiftUI

@Reducer
public struct NavigationFeature {
    @ObservableState
    public struct State: Equatable {
        public var title: String
        public var isEditing: Bool
        
        public init(title: String = "Navigation", isEditing: Bool = false) {
            self.title = title
            self.isEditing = isEditing
        }
    }
    
    @ViewAction(for: NavigationFeature.self)
    public enum Action: ViewAction, BindableAction, Sendable {
        case binding(BindingAction<State>)
        case view(View)
        
        public enum View: Equatable, Sendable {
            case editButtonTapped
            case saveButtonTapped
            case cancelButtonTapped
        }
    }
    
    public init() {}
    
    public var body: some ReducerOf<Self> {
        BindingReducer()
        
        Reduce { state, action in
            switch action {
            case .binding:
                return .none
                
            case .view(.editButtonTapped):
                state.isEditing = true
                return .none
                
            case .view(.saveButtonTapped):
                state.isEditing = false
                return .none
                
            case .view(.cancelButtonTapped):
                state.isEditing = false
                return .none
            }
        }
    }
} 
