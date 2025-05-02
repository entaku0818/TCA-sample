import ComposableArchitecture
import SwiftUI

@Reducer
struct AppFeature {
    @ObservableState
    struct State: Equatable {
        var main: MainFeature.State
        
        init(main: MainFeature.State = .init()) {
            self.main = main
        }
    }
    
    enum Action: ViewAction, BindableAction, Sendable {
        case binding(BindingAction<State>)
        case view(View)
        case main(MainFeature.Action)
        
        enum View: Equatable, Sendable {
        }
    }
    
    init() {}
    
    var body: some ReducerOf<Self> {
        BindingReducer()
        
        Scope(state: \.main, action: /Action.main) {
            MainFeature()
        }
    }
} 
