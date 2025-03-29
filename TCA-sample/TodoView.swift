//
//  TodoView.swift
//  TCA-sample
//
//  Created by AI Assistant on 2025/03/29.
//

import SwiftUI
import ComposableArchitecture

@ViewAction(for: TodoFeature.self)
struct TodoView: View {
    @Bindable var store: StoreOf<TodoFeature>

    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    TextField("新しいタスク", text: $store.newTodoTitle)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    Button(action: {
                        send(.addTodoButtonTapped)
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .font(.title2)
                    }
                    .disabled(store.newTodoTitle.isEmpty)
                }
                .padding()
                
                Toggle("完了済みのみ表示", isOn: $store.filterCompleted)
                    .padding(.horizontal)
                
                List {
                    ForEach(store.filteredTodos) { todo in
                        HStack {
                            Button(action: {
                                send(.todoCheckboxToggled(id: todo.id))
                            }) {
                                Image(systemName: todo.isCompleted ? "checkmark.square.fill" : "square")
                                    .foregroundColor(todo.isCompleted ? .green : .gray)
                            }
                            
                            Text(todo.title)
                                .strikethrough(todo.isCompleted)
                                .foregroundColor(todo.isCompleted ? .gray : .primary)
                            
                            Spacer()
                            
                            Button(action: {
                                send(.deleteTodoButtonTapped(id: todo.id))
                            }) {
                                Image(systemName: "trash")
                                    .foregroundColor(.red)
                            }
                        }
                    }
                }
                .listStyle(InsetGroupedListStyle())
            }
            .navigationTitle("TCA ToDo")
            .onAppear {
                send(.onAppear)
            }
        }

    }
}

#Preview {
    TodoView(
        store: Store(
            initialState: TodoFeature.State(),
            reducer: { TodoFeature() }
        )
    )
} 
