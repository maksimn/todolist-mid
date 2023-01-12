//
//  TodolistMIDApp.swift
//  TodolistMID
//
//  Created by Maksim Ivanov on 28.01.2022.
//

import SwiftUI
import ComposableArchitecture

struct Empty { }

private let initialState = MainTodoList.State(
    items: [],
    completedItemCount: 0,
    areCompleteItemsVisible: false,
    editor: Editor.empty()
)

private let reducer = Reducer<MainTodoList.State, MainTodoList.Action, Empty>.combine(
     AnyReducer { _ in
         Editor()
     }
     .pullback(
         state: \.editor,
         action: /MainTodoList.Action.editor,
         environment: { $0 }
     ),
     AnyReducer { _ in
         MainTodoList()
     }
).debug()

@main
struct TodoListApp: App {

    var body: some Scene {
        WindowGroup {
            MainTodoListView(
                store: Store(
                    initialState: initialState,
                    reducer: reducer,
                    environment: Empty()
                )
            )
        }
    }
}
