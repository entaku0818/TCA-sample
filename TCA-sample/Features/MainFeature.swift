import ComposableArchitecture
import SwiftUI

@Reducer
public struct MainFeature {
    @ObservableState
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
    
    public enum Action: ViewAction, BindableAction, Sendable {
        case binding(BindingAction<State>)
        case view(View)
        case navigation(NavigationFeature.Action)
        case detail(DetailFeature.Action)
        
        public enum View: Equatable {
            case viewAllTapped
            case detailDismissed
        }
    }
    
    public init() {}
    
    public var body: some ReducerOf<Self> {
        BindingReducer()
        
        Scope(state: \.navigation, action: /Action.navigation) {
            NavigationFeature()
        }
        
        Reduce { state, action in
            switch action {
            case .binding:
                return .none
                
            case .navigation:
                return .none
                
            case .view(.viewAllTapped):
                state.detail = DetailFeature.State(items: state.items)
                return .none
                
            case .view(.detailDismissed):
                state.detail = nil
                return .none
                
            case .detail:
                return .none
            }
        }
        .ifLet(\.detail, action: /Action.detail) {
            DetailFeature()
        }
    }
} 