//
//  EditorAction.swift
//  TodolistMID
//
//  Created by Maksim Ivanov on 31.08.2022.
//

import Foundation

enum EditorAction: Equatable {
    case initEditor(item: TodoItem?)
    case close
    case editorTextChanged(text: String)
    case editorPriorityChanged(priority: TodoItemPriority)
    case editorDeadlineChanged(deadline: Date?)
    case toggleDeadlinePickerVisibility
    case editorItemSaved
    case editorItemDeleted
}
