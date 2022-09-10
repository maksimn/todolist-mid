//
//  TodolistView.swift
//  TodolistMID
//
//  Created by Maksim Ivanov on 31.01.2022.
//

import ComposableArchitecture
import SwiftUI

struct TodoListView: View {

    let store: Store<TodoListState, TodoListAction>

    var body: some View {
        WithViewStore(self.store) { viewStore in
            NavigationView {
                VStack {
                    List {
                        ForEach(viewStore.state.items) { item in
                            NavigationLink(destination: navigateToEditor(item)) {
                                TodoItemCell(item: item)
                                    .swipeActions(edge: .leading, allowsFullSwipe: false) {
                                        Button(action: {
                                            viewStore.send(.toggleItemCompletion(item))
                                        }, label: {
                                            Image("finished-todo-inverse")
                                        })
                                        .tint(.green)
                                    }
                            }
                        }
                        .onDelete { indexSet in
                            for index in indexSet {
                                let item = viewStore.state.items[index]

                                viewStore.send(.deleteItem(item))
                            }
                        }

                        NewTodoItemCell(
                            text: "",
                            onTextEnter: { text in
                                viewStore.send(.createItem(TodoItem(text: text)))
                            }
                        )
                    }

                    Spacer()
                    NavigationLink(destination: navigateToEditor(nil)) {
                        Image("icon-plus")
                            .resizable()
                            .frame(width: 44, height: 44)
                            .padding(.bottom, 24)
                    }
                    .navigationTitle("Мои дела")
                    .toolbar {
                        EditButton()
                    }
                }
                .background(Color(red: 0.97, green: 0.97, blue: 0.95))
            }
        }
    }

    private func navigateToEditor(_ initialItem: TodoItem?) -> NavigationLazyView<EditorView> {
        NavigationLazyView(
            EditorView(
                store: store.scope(state: \.editorState, action: TodoListAction.editorAction),
                initialItem: initialItem
            )
        )
    }
}

struct TodoItemCell: View {

    @State
    var item: TodoItem

    var body: some View {
        HStack {
            if item.isCompleted {
                Image("finished-todo")
            } else if item.priority == .high {
                Image("high-priority-circle")
            } else {
                Image("not-finished-todo")
            }

            if item.priority == .low {
                Image("low-priority")
                    .padding(.init(top: 0, leading: 5, bottom: 0, trailing: 0))
            } else if item.priority == .high {
                Image("high-priority")
                    .padding(.init(top: 0, leading: 6, bottom: 0, trailing: 0))
            }

            VStack {
                HStack {
                    Text(item.text)
                        .strikethrough(item.isCompleted, color: Theme.data.lightTextColor)
                        .foregroundColor(item.isCompleted ? Theme.data.lightTextColor : Color.black)
                        .lineLimit(3)
                        .padding(.init(top: 0, leading: item.priority == .normal ? 8 : 2, bottom: 0, trailing: 8))

                    Spacer()
                }

                if item.deadline != nil {
                    HStack {
                        Image("small-calendar")
                            .padding(.init(top: -7, leading: 0, bottom: 0, trailing: 0))
                        Text(item.deadline?.formattedDate ?? "")
                            .font(Font.system(size: 15))
                            .foregroundColor(Theme.data.lightTextColor)
                            .padding(.init(top: -7, leading: 0, bottom: 0, trailing: 0))
                        Spacer()
                    }
                }
            }
        }
    }
}

struct NewTodoItemCell: View {

    @State
    var text: String

    var onTextEnter: (String) -> Void

    var body: some View {
        HStack {
            TextField(
                "Новое",
                text: $text
            )
            .onSubmit {
                self.onTextEnter(text)
                text = ""
            }
            .padding(.init(top: 3, leading: 24, bottom: 3, trailing: 16))
        }
    }
}
