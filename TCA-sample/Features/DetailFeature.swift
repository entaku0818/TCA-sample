import ComposableArchitecture
import SwiftUI

@Reducer
struct DetailFeature {
    @ObservableState
    struct State: Equatable {
        var items: [String]
        var title: String
        
        init(items: [String], title: String = "詳細") {
            self.items = items
            self.title = title
        }
    }
    
    enum Action: ViewAction, BindableAction, Sendable {
        case binding(BindingAction<State>)
        case view(View)
        
        enum View: Equatable {
            case itemTapped(String)
            case dismissButtonTapped
        }
    }
    
    init() {}
    
    var body: some ReducerOf<Self> {
        BindingReducer()
        
        Reduce { state, action in
            switch action {
            case .binding:
                return .none
                
            case .view(.itemTapped):
                return .none
                
            case .view(.dismissButtonTapped):
                return .none
            }
        }
    }
} 
