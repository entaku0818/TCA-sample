import ComposableArchitecture
import SwiftUI

@Reducer
struct NavigationFeature {
    @ObservableState
    struct State: Equatable {
        var title: String
        var isEditing: Bool
        
        init(title: String = "Navigation", isEditing: Bool = false) {
            self.title = title
            self.isEditing = isEditing
        }
    }
    
    enum Action: ViewAction, BindableAction, Sendable {
        case binding(BindingAction<State>)
        case view(View)
        
        enum View: Equatable, Sendable {
            case editButtonTapped
            case saveButtonTapped
            case cancelButtonTapped
        }
    }
    
    init() {}
    
    var body: some ReducerOf<Self> {
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
