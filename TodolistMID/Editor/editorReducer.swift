//
//  editorReducer.swift
//  TodolistMID
//
//  Created by Maksim Ivanov on 31.08.2022.
//

import ComposableArchitecture
import Foundation

let editorReducer = Reducer<EditorState?, EditorAction, EditorEnvironment> { state, action, _ in

    switch action {
    case .initEditor(let item):
        state = nextStateForInitEditorAction(item: item)

    case .close:
        state = nil

    case .editorTextChanged(let text):
        state = nextStateForEditorTextChangedAction(text, state)

    case .editorPriorityChanged(let priority):
        state = nextStateForEditorPriorityChangedAction(priority, state)

    case .editorDeadlineChanged(let deadline):
        state = nextStateForEditorDeadlineChanged(deadline, state)

    case .toggleDeadlinePickerVisibility:
        state = nextStateForToggleDeadlinePickerVisibilityAction(state)

    case .editorItemSaved:
        state = nextStateForEditorItemSavedAction(state)

    case .editorItemDeleted:
        state = createEmptyState()
    }

    return .none
}

private func createEmptyState() -> EditorState {
    EditorState(
        mode: .creating,
        item: TodoItem(),
        savedItem: nil,
        isDeadlinePickerHidden: true
    )
}

private func nextStateForInitEditorAction(item: TodoItem?) -> EditorState? {
    let emptyState = createEmptyState()

    if let item = item {
        return EditorState(
            mode: .editing,
            item: item,
            savedItem: item,
            isDeadlinePickerHidden: emptyState.isDeadlinePickerHidden
        )
    } else {
        return emptyState
    }
}

private func nextStateForEditorTextChangedAction(_ text: String, _ state: EditorState?) -> EditorState? {
    guard let state = state else { return state }
    var newState = state

    newState.item = state.item.update(text: text)

    return newState
}

private func nextStateForEditorPriorityChangedAction(_ priority: TodoItemPriority,
                                                     _ state: EditorState?) -> EditorState? {
    guard let state = state else { return state }
    var newState = state

    newState.item = state.item.update(priority: priority)

    return newState
}

private func nextStateForEditorDeadlineChanged(_ deadline: Date?, _ state: EditorState?) -> EditorState? {
    guard let state = state else { return state }
    var newState = state

    newState.item = newState.item.update(deadline: deadline)

    return newState
}

private func nextStateForToggleDeadlinePickerVisibilityAction(_ state: EditorState?) -> EditorState? {
    guard let state = state else { return state }
    var newState = state

    newState.isDeadlinePickerHidden = !state.isDeadlinePickerHidden

    return newState
}

private func nextStateForEditorItemSavedAction(_ state: EditorState?) -> EditorState? {
    guard let state = state else { return state }
    var newState = state

    newState.mode = .editing
    newState.savedItem = state.item

    return newState
}
