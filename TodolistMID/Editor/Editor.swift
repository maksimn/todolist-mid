//
//  Editor.swift
//  TodolistMID
//
//  Created by Maksim Ivanov on 11.01.2023.
//

import ComposableArchitecture
import Foundation

struct Editor: ReducerProtocol {

    enum Mode { case creating, editing }

    struct State: Equatable {
        var mode: Mode
        var item: TodoItem
        var savedItem: TodoItem?
        var isDeadlinePickerHidden: Bool

        var canItemBeSaved: Bool {
            let isStateAfterSaving = mode == .editing && item == savedItem

            return !isInitialState && !isStateAfterSaving
        }

        var canItemBeRemoved: Bool {
            !isInitialState
        }

        private var isInitialState: Bool {
            let empty = TodoItem()

            return mode == .creating &&
                savedItem == nil &&
                item.text == empty.text &&
                item.priority == empty.priority &&
                item.deadline == empty.deadline
        }
    }

    enum Action: Equatable {
        case initEditor(item: TodoItem?)
        case close
        case editorTextChanged(text: String)
        case editorPriorityChanged(priority: TodoItemPriority)
        case editorDeadlineChanged(deadline: Date?)
        case toggleDeadlinePickerVisibility
        case editorItemSaved
        case editorItemDeleted
    }

    func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
        switch action {
        case .initEditor(let item):
            state = nextStateForInitEditorAction(item: item)

        case .close:
            state = createEmptyState()

        case .editorTextChanged(let text):
            state.item = state.item.update(text: text)

        case .editorPriorityChanged(let priority):
            state.item = state.item.update(priority: priority)

        case .editorDeadlineChanged(let deadline):
            state.item = state.item.update(deadline: deadline)

        case .toggleDeadlinePickerVisibility:
            state.isDeadlinePickerHidden.toggle()

        case .editorItemSaved:
            state.mode = .editing
            state.savedItem = state.item

        case .editorItemDeleted:
            state = createEmptyState()
        }

        return .none
    }

    private func createEmptyState() -> State {
        State(
            mode: .creating,
            item: TodoItem(),
            savedItem: nil,
            isDeadlinePickerHidden: true
        )
    }

    private func nextStateForInitEditorAction(item: TodoItem?) -> State {
        let emptyState = createEmptyState()

        if let item = item {
            return State(
                mode: .editing,
                item: item,
                savedItem: item,
                isDeadlinePickerHidden: emptyState.isDeadlinePickerHidden
            )
        } else {
            return emptyState
        }
    }
}
