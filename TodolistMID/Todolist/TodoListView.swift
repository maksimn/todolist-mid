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
        NavigationView {
            WithViewStore(self.store) { viewStore in
                VStack {
                    List {
                        ForEach(viewStore.state.items) {
                            TodoItemCell(item: $0)
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

private let lightTextColor = Color(red: 0.7, green: 0.7, blue: 0.7)

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
                        .strikethrough(item.isCompleted, color: lightTextColor)
                        .foregroundColor(item.isCompleted ? lightTextColor : Color.black)
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
                            .foregroundColor(lightTextColor)
                            .padding(.init(top: -7, leading: 0, bottom: 0, trailing: 0))
                        Spacer()
                    }
                }
            }

            Image("right-arrow")
                .padding(.init(top: 0, leading: 0, bottom: 0, trailing: 8))
        }
    }
}
