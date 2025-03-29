import Foundation
import ComposableArchitecture
import SwiftUI

@Reducer
struct TodoFeature {
    @ObservableState
    struct State: Equatable {
        var todos: IdentifiedArrayOf<Todo> = []
        var newTodoTitle: String = ""
        var filterCompleted: Bool = false
        
        var filteredTodos: IdentifiedArrayOf<Todo> {
            filterCompleted 
                ? todos.filter { $0.isCompleted } 
                : todos
        }
    }
    
    enum Action: ViewAction, BindableAction, Sendable {
        case binding(BindingAction<State>)
        case view(View)

        enum View: Equatable {
            case onAppear
            case addTodoButtonTapped
            case todoCheckboxToggled(id: Todo.ID)
            case deleteTodoButtonTapped(id: Todo.ID)
        }
    }
    
    var body: some ReducerOf<Self> {
        BindingReducer()
        
        Reduce { state, action in
            switch action {
            case .binding:
                return .none
                
            case .view(.onAppear):
                if state.todos.isEmpty {
                    state.todos.append(Todo(title: "TCAを学習する"))
                    state.todos.append(Todo(title: "BindableActionの使い方を理解する"))
                    state.todos.append(Todo(title: "ViewActionの使い方を理解する"))
                }
                return .none
                
            case .view(.addTodoButtonTapped):
                guard !state.newTodoTitle.isEmpty else {
                    return .none
                }

                state.todos.append(
                    Todo(title: state.newTodoTitle)
                )
                state.newTodoTitle = ""
                return .none
                
            case let .view(.todoCheckboxToggled(id)):
                if let index = state.todos.index(id: id) {
                    var updatedTodo = state.todos[index]
                    updatedTodo.isCompleted.toggle()
                    
                    state.todos[id: id] = updatedTodo
                }
                return .none
                
            case let .view(.deleteTodoButtonTapped(id)):
                state.todos.remove(id: id)
                return .none
            }
        }
    }
}
