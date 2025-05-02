import ComposableArchitecture
import SwiftUI

@Reducer
public struct AppFeature {
    @ObservableState
    public struct State: Equatable {
        public var main: MainFeature.State
        
        public init(main: MainFeature.State = .init()) {
            self.main = main
        }
    }
    
    @ViewAction(for: AppFeature.self)
    public enum Action: ViewAction, BindableAction, Sendable {
        case binding(BindingAction<State>)
        case view(View)
        case main(MainFeature.Action)
        
        public enum View: Equatable, Sendable {
        }
    }
    
    public init() {}
    
    public var body: some ReducerOf<Self> {
        BindingReducer()
        
        Scope(state: \.main, action: /Action.main) {
            MainFeature()
        }
    }
} 
