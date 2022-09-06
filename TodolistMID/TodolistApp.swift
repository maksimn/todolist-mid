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
    editorState: nil
)

private let reducer = todoListReducer.combined(
    with: editorReducer.pullback(
        state: \.editorState,
        action: /TodoListAction.editorAction,
        environment: { _ in EditorEnvironment() }
    )
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
