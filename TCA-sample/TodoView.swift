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
            VStack(spacing: 0) {
                VStack(spacing: 16) {
                    HStack {
                        TextField("新しいタスク", text: $store.newTodoTitle)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        
                        Button(action: {
                            send(.addTodoButtonTapped)
                        }) {
                            Image(systemName: "plus.circle.fill")
                                .font(.title2)
                                .foregroundColor(.blue)
                        }
                        .disabled(store.newTodoTitle.isEmpty)
                    }
                    
                    HStack {
                        Toggle("完了済みのみ表示", isOn: $store.filterCompleted)
                            .tint(.green)
                        
                        Spacer()
                        
                        Text(store.filterCompleted ? "完了タスクのみ表示中" : "すべてのタスク表示中")
                            .font(.caption)
                            .foregroundColor(store.filterCompleted ? .green : .gray)
                            .animation(.easeInOut, value: store.filterCompleted)
                    }
                    .padding(.vertical, 8)
                    .padding(.horizontal, 12)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(8)
                }
                .padding()
                .background(Color.white)
                .zIndex(1)
                .shadow(color: .black.opacity(0.05), radius: 5, x: 0, y: 2)
                
                if store.filteredTodos.isEmpty {
                    VStack(spacing: 20) {
                        if store.todos.isEmpty {
                            Image(systemName: "checkmark.circle.badge.plus")
                                .font(.system(size: 60))
                                .foregroundColor(.gray.opacity(0.3))
                            
                            Text("タスクを追加して\n始めましょう！")
                                .font(.title2)
                                .multilineTextAlignment(.center)
                                .foregroundColor(.gray)
                        } else if store.filterCompleted {
                            Image(systemName: "checkmark.circle")
                                .font(.system(size: 60))
                                .foregroundColor(.green.opacity(0.3))
                            
                            Text("完了したタスクはありません")
                                .font(.title2)
                                .foregroundColor(.gray)
                            
                            Button("すべてのタスクを表示") {
                                store.filterCompleted = false
                            }
                            .buttonStyle(.bordered)
                            .tint(.blue)
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.gray.opacity(0.03))
                } else {
                    ScrollView {
                        LazyVStack(spacing: 0) {
                            ForEach(store.filteredTodos) { todo in
                                TodoItemView(todo: todo) {
                                    send(.todoCheckboxToggled(id: todo.id))
                                } onDelete: {
                                    send(.deleteTodoButtonTapped(id: todo.id))
                                }
                                
                                if todo.id != store.filteredTodos.last?.id {
                                    Divider()
                                        .padding(.leading, 50)
                                }
                            }
                        }
                        .background(Color.white)
                        .cornerRadius(10)
                        .padding(.horizontal)
                        .padding(.top)
                    }
                }
            }
            .navigationTitle("TCA ToDo")
            .onAppear {
                send(.onAppear)
            }
            .background(Color.gray.opacity(0.05))
        }
    }
}

struct TodoItemView: View {
    let todo: Todo
    let onToggle: () -> Void
    let onDelete: () -> Void
    
    var body: some View {
        HStack(spacing: 16) {
            Button(action: onToggle) {
                ZStack {
                    Circle()
                        .stroke(todo.isCompleted ? Color.green : Color.gray, lineWidth: 1.5)
                        .frame(width: 24, height: 24)
                    
                    if todo.isCompleted {
                        Image(systemName: "checkmark")
                            .font(.system(size: 12, weight: .bold))
                            .foregroundColor(.green)
                    }
                }
            }
            
            Text(todo.title)
                .strikethrough(todo.isCompleted)
                .foregroundColor(todo.isCompleted ? .gray : .primary)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Button(action: onDelete) {
                Image(systemName: "trash")
                    .foregroundColor(.red.opacity(0.7))
            }
            .buttonStyle(.plain)
        }
        .padding(.vertical, 12)
        .padding(.horizontal, 16)
        .contentShape(Rectangle())
        .background(
            todo.isCompleted ? 
                Color.green.opacity(0.05) : 
                Color.white
        )
        .animation(.easeOut(duration: 0.2), value: todo.isCompleted)
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
