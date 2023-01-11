//
//  MainTodoList.swift
//  TodolistMID
//
//  Created by Maksim Ivanov on 12.01.2023.
//

import ComposableArchitecture

struct MainTodoList: ReducerProtocol {

    struct State: Equatable {
        var items: [TodoItem]
        var completedItemCount: Int
        var areCompleteItemsVisible: Bool
        var editor: Editor.State
    }

    enum Action: Equatable {
        case createItem(TodoItem)
        case toggleItemCompletion(TodoItem)
        case deleteItem(TodoItem)
        case switchCompletedItemsVisibility
        case editor(Editor.Action)
    }

    func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
        switch action {
        case .createItem(let item):
            state.items.append(item)

        case .toggleItemCompletion(let item):
            state = nextState(toggleCompletionFor: item, state)

        case .deleteItem(let item):
            state = nextState(delete: item, state)

        case .switchCompletedItemsVisibility:
            state.areCompleteItemsVisible.toggle()

        case .editor(.editorItemSaved):
            state = nextState(editorItemSaved: state)

        case .editor(.editorItemDeleted):
            state = nextState(editorItemDeleted: state)

        case .editor(.close):
            state.editor = Editor.empty()

        default:
            return .none
        }

        return .none
    }

    private func nextState(toggleCompletionFor item: TodoItem, _ state: State) -> State {
        var state = state
        guard let index = state.items.firstIndex(where: { $0.persId == item.persId }) else {
            return state
        }

        let item = state.items[index]
        let newItem = item.update(isCompleted: !item.isCompleted)

        state.items[index] = newItem

        if newItem.isCompleted {
            state.completedItemCount += 1
        } else if state.completedItemCount > 0 {
            state.completedItemCount -= 1
        }

        return state
    }

    private func nextState(delete item: TodoItem, _ state: State) -> State {
        guard let index = state.items.firstIndex(where: { $0.persId == item.persId }) else { return state }
        let item = state.items[index]
        var state = state

        state.items.remove(at: index)

        if item.isCompleted && state.completedItemCount > 0 {
            state.completedItemCount -= 1
        }

        return state
    }

    private func nextState(editorItemSaved state: State) -> State {
        let item = state.editor.item
        var newState = state

        if let index = newState.items.firstIndex(where: { $0.persId == item.persId }) {
            newState.items[index] = item
        } else {
            newState.items.append(item)
        }

        return newState
    }

    private func nextState(editorItemDeleted state: State) -> State {
        let deletedItem = state.editor.item
        var state = state

        if let index = state.items.firstIndex(where: { $0.persId == deletedItem.persId }) {
            state.items.remove(at: index)
        }

        return state
    }
}
