//
//  TodoItemView.swift
//  TodolistMID
//
//  Created by Maksim Ivanov on 12.01.2023.
//

import SwiftUI

struct TodoItemView: View {

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

struct NewTodoItemView: View {

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
