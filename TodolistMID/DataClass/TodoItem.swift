//
//  TodoItem.swift
//  TodolistMID
//
//  Created by Maksim Ivanov on 31.08.2022.
//

import Foundation

enum TodoItemPriority: String {
    case high
    case normal
    case low
}

struct TodoItem: Equatable {

    let id: String
    let text: String
    let priority: TodoItemPriority
    let deadline: Date?
    let isCompleted: Bool
    let createdAt: Int
    let updatedAt: Int
    let isDirty: Bool

    init(id: String = UUID().uuidString,
         text: String = "",
         priority: TodoItemPriority = .normal,
         deadline: Date? = nil,
         isCompleted: Bool = false,
         createdAt: Int? = nil,
         updatedAt: Int? = nil,
         isDirty: Bool = false) {
        self.id = id
        self.text = text
        self.priority = priority
        self.deadline = deadline
        self.isCompleted = isCompleted
        self.isDirty = isDirty
        let now = Date()
        self.createdAt = createdAt ?? now.integer
        self.updatedAt = updatedAt ?? now.integer
    }

    func update(text: String? = nil,
                priority: TodoItemPriority? = nil,
                isCompleted: Bool? = nil,
                updatedAt: Int = Date().integer) -> TodoItem {
        TodoItem(id: self.id,
                 text: text ?? self.text,
                 priority: priority ?? self.priority,
                 deadline: self.deadline,
                 isCompleted: isCompleted ?? self.isCompleted,
                 createdAt: self.createdAt,
                 updatedAt: updatedAt,
                 isDirty: isDirty)
    }

    func update(isDirty: Bool) -> TodoItem {
        TodoItem(id: self.id,
                 text: text,
                 priority: priority,
                 deadline: deadline,
                 isCompleted: isCompleted,
                 createdAt: createdAt,
                 updatedAt: updatedAt,
                 isDirty: isDirty)
    }

    func update(deadline: Date?) -> TodoItem {
        TodoItem(id: self.id,
                 text: text,
                 priority: priority,
                 deadline: deadline,
                 isCompleted: isCompleted,
                 createdAt: createdAt,
                 updatedAt: Date().integer,
                 isDirty: isDirty)
    }

    static func == (lhs: TodoItem, rhs: TodoItem) -> Bool {
        lhs.id == rhs.id &&
        lhs.text == rhs.text &&
        lhs.priority == rhs.priority &&
        lhs.deadline?.timeIntervalSince1970 == rhs.deadline?.timeIntervalSince1970 &&
        lhs.isCompleted == rhs.isCompleted &&
        lhs.createdAt == rhs.createdAt &&
        lhs.updatedAt == rhs.updatedAt &&
        lhs.isDirty == rhs.isDirty
    }
}
