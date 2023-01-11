//
//  TodoListView+Preview.swift
//  TodolistMID
//
//  Created by Maksim Ivanov on 06.09.2022.
//

import ComposableArchitecture
import SwiftUI

private let state = TodoListState(
    items: [
        TodoItem(text: "Battle of Algeria",
                 isCompleted: true),
        TodoItem(text: "Правила игры Жана Ренуара, 1938 год, из серии World Movie Classics.",
                 priority: .high),
        TodoItem(text: """
        Long text. Long text. Long text. Long text. Long text. Long text. Long text. Long text. Long text. Long text.
        Long text. Long text. Long text. Long text. Long text. Long text.
        """,
                 priority: .low,
                 deadline: Date(timeIntervalSince1970: 0))
    ],
    completedItemCount: 0,
    areCompleteItemsVisible: false,
    editorState: Editor.State(mode: .creating, item: TodoItem(), isDeadlinePickerHidden: true)
)

private let reducer = Reducer<TodoListState, TodoListAction, TodoListEnvironment> { _, _, _ in
    return .none
}

private let store = Store(
    initialState: state,
    reducer: reducer,
    environment: TodoListEnvironment()
)

struct TodoListView_Previews: PreviewProvider {
    static var previews: some View {
        TodoListView(store: store)
    }
}
