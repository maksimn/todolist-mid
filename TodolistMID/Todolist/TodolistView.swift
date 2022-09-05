//
//  TodolistView.swift
//  TodolistMID
//
//  Created by Maksim Ivanov on 31.01.2022.
//

import ComposableArchitecture
import SwiftUI

struct TodolistView: View {

    let store: Store<TodoListState, TodoListAction>

    var body: some View {
        NavigationView {
            WithViewStore(self.store) { viewStore in
                VStack {
                    List {
                        ForEach(viewStore.state.items) {
                            TodoItemCell(state: $0)
                        }
                    }

                    Spacer()
                    NavigationLink(
                        destination: NavigationLazyView(
                            EditorView(
                                store: store.scope(state: \.editorState, action: TodoListAction.editorAction)
                            )
                        )
                    ) {
                        Image("icon-plus")
                            .resizable()
                            .frame(width: 44, height: 44)
                            .padding(.bottom, 24)
                    }
                    .navigationTitle("Мои дела")
                }
                .background(Color(red: 0.97, green: 0.97, blue: 0.95))
            }
        }
    }
}

struct TodoItemCell: View {

    @State
    var state: TodoItem

    var body: some View {
        HStack {
            Image("not-finished-todo")
            Text(state.text).lineLimit(3)
            Spacer()
            Image("right-arrow")
        }
    }
}
