//
//  TodoItemMO.swift
//  ToDoList
//
//  Created by Maxim Ivanov on 06.07.2021.
//

import CoreData

@objc(TodoItemMO)
class TodoItemMO: NSManagedObject {

    @NSManaged var createdAt: Date?
    @NSManaged var deadline: Date?
    @NSManaged var id: String?
    @NSManaged var isCompleted: Bool
    @NSManaged var isDirty: Bool
    @NSManaged var priority: String?
    @NSManaged var text: String?
    @NSManaged var updatedAt: Date?

    static var name: String {
        "TodoItemMO"
    }

    @nonobjc class func fetchRequest() -> NSFetchRequest<TodoItemMO> {
        return NSFetchRequest<TodoItemMO>(entityName: TodoItemMO.name)
    }

    func set(_ todoItem: TodoItem) {
        self.id = todoItem.persId
        self.text = todoItem.text
        self.priority = TodoItemMO.mapPriority(todoItem.priority)
        self.deadline = todoItem.deadline
        self.isCompleted = todoItem.isCompleted
        self.createdAt = Date(timeIntervalSince1970: TimeInterval(todoItem.createdAt))
        self.updatedAt = Date(timeIntervalSince1970: TimeInterval(todoItem.updatedAt))
        self.isDirty = todoItem.isDirty
    }

    var todoItem: TodoItem {
        TodoItem(persId: self.id ?? "",
                 text: self.text ?? "",
                 priority: TodoItemMO.mapPriority(self.priority ?? ""),
                 deadline: self.deadline,
                 isCompleted: self.isCompleted,
                 createdAt: self.createdAt?.integer ?? 0,
                 updatedAt: self.updatedAt?.integer ?? 0,
                 isDirty: self.isDirty)
    }

    static func mapPriority(_ string: String) -> TodoItemPriority {
        switch string {
        case "low":
            return .low
        case "important":
            return .high
        default:
            return .normal
        }
    }

    static func mapPriority(_ priority: TodoItemPriority) -> String {
        switch priority {
        case .high:
            return "important"
        case .low:
            return "low"
        default:
            return "basic"
        }
    }
}
