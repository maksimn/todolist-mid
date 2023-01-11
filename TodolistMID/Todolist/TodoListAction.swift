//
//  TodoListAction.swift
//  TodolistMID
//
//  Created by Maksim Ivanov on 02.09.2022.
//

enum TodoListAction: Equatable {
    case createItem(TodoItem)
    case toggleItemCompletion(TodoItem)
    case deleteItem(TodoItem)
    case switchCompletedItemsVisibility
    case editorAction(Editor.Action)
}
