//
//  TaskEntity.swift
//  TodoApp
//
//  Created by Serhii Liubeznov on 28.02.2023.
//

import UIKit
import CoreData

class TaskEntity: NSManagedObject {
    @NSManaged public var id: String
    @NSManaged public var body: String
    @NSManaged public var priority: String
    @NSManaged public var title: String
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<TaskEntity> {
        return NSFetchRequest<TaskEntity>(entityName: "TaskEntity")
    }
    
    convenience init(task: Task, context: NSManagedObjectContext) {
        self.init(context: context)
        
        self.id = task.id
        self.body = task.description
        self.priority = task.priority
        self.title = task.title
    }
    
    func convertToTask() -> Task {
        return Task(id: id, title: title, description: body, priority: priority)
    }
}
