//
//  TaskAPI.swift
//  TodoApp
//
//  Created by Serhii Liubeznov on 27.02.2023.
//

import Foundation

struct TaskAPIBody: Encodable {
    let description: String
    let priority: String
    let title: String
    
    init(from: Task) {
        self.priority = from.priority
        self.description = from.description
        self.title = from.title
    }
}

struct TaskAPI: Decodable {
    let id: String
    let description: String
    let priority: String
    let title: String
}

extension TaskAPI {
    func convertToTask() -> Task {
        return Task(id: id, title: title, description: description, priority: priority)
    }
}
