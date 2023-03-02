//
//  TasksService.swift
//  TodoApp
//
//  Created by Serhii Liubeznov on 27.02.2023.
//

import Foundation

typealias TasksResult = (Result<[Task], Error>) -> Void
typealias TaskResult = (Result<Task, Error>) -> Void
typealias TaskRemoveResult = (Error?) -> Void

protocol TasksService {
    func getTasks(_ completion: @escaping(TasksResult))
    func addTask(_ task: Task, completion: @escaping(TaskResult))
    func deleteTask(id: String, completion: @escaping(TaskRemoveResult))
}

class TasksNetworkService: NetworkService, TasksService {
    
    func deleteTask(id: String, completion: @escaping (TaskRemoveResult)) {
        delete(route: .taskDelete(id: id)) { (response: Result<TaskAPI, Error>) in
            do {
                _ = try response.get().convertToTask()
                completion(nil)
            } catch {
                completion(error)
            }
        }
    }
    
    func addTask(_ task: Task, completion: @escaping (TaskResult)) {
        
        let body = try? JSONEncoder().encode(TaskAPIBody(from: task))
        
        post(route: .tasks, body: body) { (response: Result<TaskAPI, Error>) in
            do {
                let task = try response.get().convertToTask()
                completion(.success(task))
            } catch {
                completion(.failure(error))
            }
        }
    }
    
    func getTasks(_ completion: @escaping (TasksResult)) {
        get(route: .tasks) { (response: Result<[TaskAPI], Error>) in
            do {
                let tasks = try response.get().map({$0.convertToTask()})
                completion(.success(tasks))
            } catch {
                completion(.failure(error))
            }
        }
    }
}
