import ComposableArchitecture
import SwiftUI

@Reducer
public struct DetailFeature {
    @ObservableState
    public struct State: Equatable {
        public var items: [String]
        public var title: String
        @Presents public var alert: AlertState<AlertAction>?
        
        public init(items: [String], title: String = "詳細") {
            self.items = items
            self.title = title
        }
    }
    
    public enum Action: ViewAction, BindableAction, Sendable {
        case binding(BindingAction<State>)
        case view(View)
        case alert(PresentationAction<AlertAction>)
        
        public enum View: Equatable {
            case itemTapped(String)
            case dismissButtonTapped
        }
        
        public enum AlertAction: Equatable {
            case confirmDismiss
            case cancelDismiss
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
                
            case .view(.dismissButtonTapped):
                state.alert = AlertState {
                    TextState("確認")
                } actions: {
                    ButtonState(role: .destructive, action: .confirmDismiss) {
                        TextState("閉じる")
                    }
                    ButtonState(role: .cancel, action: .cancelDismiss) {
                        TextState("キャンセル")
                    }
                } message: {
                    TextState("画面を閉じますか？")
                }
                return .none
                
            case .alert(.presented(.confirmDismiss)):
                return .none
                
            case .alert(.presented(.cancelDismiss)):
                state.alert = nil
                return .none
                
            case .alert:
                return .none
            }
        }
        .ifLet(\.$alert, action: \.alert)
    }
} 