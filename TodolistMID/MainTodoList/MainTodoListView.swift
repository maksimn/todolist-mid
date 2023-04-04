//
//  MainTodoListView.swift
//  TodolistMID
//
//  Created by Maksim Ivanov on 12.01.2023.
//

import ComposableArchitecture
import SwiftUI

struct MainTodoListView: View {

    let store: StoreOf<MainTodoList>

    var body: some View {
        WithViewStore(self.store) { viewStore in
            NavigationView {
                VStack {
                    HStack {
                        Text("Выполнено — \(viewStore.state.completedItemCount)")
                            .foregroundColor(Color.gray)
                            .padding(.init(top: 12, leading: 24, bottom: 0, trailing: 10))
                        Spacer()
                        Button(
                            action: {
                                viewStore.send(.switchCompletedItemsVisibility)
                            },
                            label: {
                                Text(viewStore.state.areCompleteItemsVisible ? "Скрыть" : "Показать")
                                    .fontWeight(.medium)
                                    .foregroundColor(viewStore.state.completedItemCount == 0 ? Color.gray : Color.blue)
                            }
                        )
                        .disabled(viewStore.state.completedItemCount == 0)
                        .padding(.init(top: 12, leading: 10, bottom: 0, trailing: 26))
                    }
                    VStack {
                        List {
                            ForEach(
                                viewStore.state.areCompleteItemsVisible ?
                                viewStore.state.items :
                                viewStore.state.items.filter { !$0.isCompleted }
                            ) { item in
                                NavigationLink(destination: navigateToEditor(item)) {
                                    TodoItemView(item: item)
                                }
                            }
                            .onDelete { indexSet in
                                for index in indexSet {
                                    let item = viewStore.state.items[index]

                                    viewStore.send(.deleteItem(item))
                                }
                            }

                            NewTodoItemView(
                                text: "",
                                onTextEnter: { text in
                                    viewStore.send(.createItem(TodoItem(text: text)))
                                }
                            )
                        }
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
                store: store.scope(
                    state: \.editor,
                    action: { MainTodoList.Action.editor($0) }
                ),
                initialItem: initialItem
            )
        )
    }
}
