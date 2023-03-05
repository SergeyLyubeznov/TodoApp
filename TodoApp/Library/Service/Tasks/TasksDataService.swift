//
//  TasksDataService.swift
//  TodoApp
//
//  Created by Serhii Liubeznov on 28.02.2023.
//

import Foundation
import CoreData

protocol TasksDataServiceProtocol {
    func getTasks() -> [Task]
    func addTasks(_ tasks: [Task])
    func removeTaskById(_ id: String)
    func removeAllTasks()
}

class TasksDataService: TasksDataServiceProtocol {
    
    private let coreData = CoreDataService.shared
    
    func getTasks() -> [Task] {
        let request: NSFetchRequest<TaskEntity> = TaskEntity.fetchRequest()
        if let tasks = try? self.coreData.contenxt.fetch(request) {
            return tasks.map({$0.convertToTask()})
        } else {
            return []
        }
    }
    
    func addTasks(_ tasks: [Task]) {
        coreData.contenxt.perform {
            for task in tasks {
                if let existedTask = self.findTaskById(task.id) {
                    existedTask.priority = task.priority
                    existedTask.body = task.description
                } else {
                    _ = TaskEntity(task: task, context: self.coreData.contenxt)
                }
            }
            
            try? self.coreData.contenxt.save()
        }
    }
    
    func removeAllTasks() {
        let request: NSFetchRequest<TaskEntity> = TaskEntity.fetchRequest()
        if let tasks = try? self.coreData.contenxt.fetch(request) {
            coreData.contenxt.perform {
                tasks.forEach({self.coreData.contenxt.delete($0)})
            }
        }
    }
    
    func removeTaskById(_ id: String) {
        coreData.contenxt.perform {
            if let task = self.findTaskById(id) {
                self.coreData.contenxt.delete(task)
            }
        }
    }
    
    private func findTaskById(_ id: String) -> TaskEntity? {
        let request: NSFetchRequest<TaskEntity> = TaskEntity.fetchRequest()
        let predicate: NSPredicate = NSPredicate(format: "id == %@", id)
        request.predicate = predicate
        return try? coreData.contenxt.fetch(request).first
    }
}
