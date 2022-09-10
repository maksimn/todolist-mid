//
//  todoListReducer.swift
//  TodolistMID
//
//  Created by Maksim Ivanov on 02.09.2022.
//

import ComposableArchitecture

let todoListReducer = Reducer<TodoListState, TodoListAction, TodoListEnvironment> { state, action, _ in
    switch action {
    case .createItem(let item):
        state = nextState(create: item, state)

    case .toggleItemCompletion(let item):
        state = nextState(toggleCompletionFor: item, state)

    case .deleteItem(let item):
        state = nextState(delete: item, state)

    case .switchCompletedItemsVisibility:
        state = nextState(switchCompletedItemsVisibilityFor: state)

    case .editorAction(.editorItemSaved):
        state = nextState(editorItemSaved: state)

    case .editorAction(.editorItemDeleted):
        state = nextState(editorItemDeleted: state)

    default:
        return .none
    }

    return .none
}

private func nextState(create item: TodoItem, _ state: TodoListState) -> TodoListState {
    var newState = state

    newState.items.append(item)

    return newState
}

private func nextState(toggleCompletionFor item: TodoItem, _ state: TodoListState) -> TodoListState {
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

private func nextState(delete item: TodoItem, _ state: TodoListState) -> TodoListState {
    guard let index = state.items.firstIndex(where: { $0.persId == item.persId }) else { return state }
    let item = state.items[index]
    var state = state

    state.items.remove(at: index)

    if item.isCompleted && state.completedItemCount > 0 {
        state.completedItemCount -= 1
    }

    return state
}

private func nextState(switchCompletedItemsVisibilityFor state: TodoListState) -> TodoListState {
    var state = state

    state.areCompleteItemsVisible.toggle()

    return state
}

private func nextState(editorItemSaved state: TodoListState) -> TodoListState {
    guard let item = state.editorState?.item else {
        return state
    }
    var newState = state

    if let index = newState.items.firstIndex(where: { $0.persId == item.persId }) {
        newState.items[index] = item
    } else {
        newState.items.append(item)
    }

    return newState
}

private func nextState(editorItemDeleted state: TodoListState) -> TodoListState {
    guard let deletedItem = state.editorState?.item else {
        return state
    }
    var state = state

    if let index = state.items.firstIndex(where: { $0.persId == deletedItem.persId }) {
        state.items.remove(at: index)
    }

    return state
}
