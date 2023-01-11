//
//  TodolistMIDApp.swift
//  TodolistMID
//
//  Created by Maksim Ivanov on 28.01.2022.
//

import SwiftUI
import ComposableArchitecture

private let initialTodoListState = TodoListState(
    items: [],
    completedItemCount: 0,
    areCompleteItemsVisible: false,
    editorState: Editor.State(mode: .creating, item: TodoItem(), isDeadlinePickerHidden: true)
)

private let reducer = Reducer<TodoListState, TodoListAction, TodoListEnvironment>.combine(
    AnyReducer { _ in
        Editor()
    }
    .pullback(
        state: \.editorState,
        action: /TodoListAction.editorAction,
        environment: { $0 }
    ),
    todoListReducer
).debug()

@main
struct TodolistApp: App {

    var body: some Scene {
        WindowGroup {
            TodoListView(
                store: Store(
                    initialState: initialTodoListState,
                    reducer: reducer,
                    environment: TodoListEnvironment()
                )
            )
        }
    }
}
