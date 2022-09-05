//
//  TodoListState.swift
//  TodolistMID
//
//  Created by Maksim Ivanov on 02.09.2022.
//

struct TodoListState: Equatable {
    var items: [TodoItem]
    var completedItemCount: Int
    var areCompleteItemsVisible: Bool
    var editorState: EditorState?
}
