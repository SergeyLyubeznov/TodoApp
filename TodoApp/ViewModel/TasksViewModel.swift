//
//  TasksViewModel.swift
//  TodoApp
//
//  Created by Serhii Liubeznov on 28.02.2023.
//

import Foundation
import Combine
import UIKit

enum TaskPriority: String {
    case low, mid, hight
    
    var color: UIColor {
        switch self {
        case .low:
            return UIColor(hex: Constants.Colors.TaskLowPriority)
        case .mid:
            return UIColor(hex: Constants.Colors.TaskMidPriority)
        case .hight:
            return UIColor(hex: Constants.Colors.TaskHightPriority)
        }
    }
}

extension TaskPriority {
    static subscript(index: Int) -> TaskPriority {
        switch index {
        case 0:
            return .low
        case 1:
            return .mid
        case 2:
            return .hight
        default:
            return .low
        }
    }
}

protocol ViewModel: AnyObject {
    var success: Bool {get set}
    var error: Error? {get set}
    var activityIndicator: Bool {get set}
    
    func updateActivityIndicator(state: Bool)

}

extension ViewModel {
    func updateActivityIndicator(state: Bool) {
        DispatchQueue.main.async {
            self.activityIndicator = state
        }
    }
}

class TasksViewModel: ViewModel {
    
    @Published var error: Error?
    @Published var success = false
    @Published var activityIndicator = false
    var tasks: [TaskViewModel] = []
    
    private var taskModels: [Task] = []
    private let networkService: TasksService
    private let dataService = TasksDataService()
    
    init(networkService: TasksService) {
        self.networkService = networkService
    }
    
    func update() {
        taskModels = dataService.getTasks()
        tasks = taskModels.map({task in
            let color = TaskPriority(rawValue: task.priority)?.color ?? .black
            return TaskViewModel(id: task.id, title: task.title,
                                 description: task.description, color: color)
            
        })
        self.success = true
    }
    
    func getTasks() {
        updateActivityIndicator(state: true)
        DispatchQueue.global(qos: .utility).asyncAfter(deadline: .now() + 1) {
            self.networkService.getTasks { result in
                self.updateActivityIndicator(state: false)
                do {
                    let tasks = try result.get()
                    self.dataService.removeAllTasks()
                    self.dataService.addTasks(tasks)
                    DispatchQueue.main.async {
                        self.update()
                    }
                } catch {
                    print(error)
                }
            }
        }
    }
    
    func addTask(_ title: String, _ description: String) {
        
        let titleRand = Int.random(in: 10..<50)
        let descrRand = Int.random(in: 10..<100)
        let priority = TaskPriority[Int.random(in: 0..<3)]
        let title = title.isEmpty ? String.randomStringWithLength(titleRand) : title
        let description = description.isEmpty ? String.randomStringWithLength(descrRand) : description
        let task = Task(id: "", title: title, description: description,
                        priority: priority.rawValue)
        
        updateActivityIndicator(state: true)
        DispatchQueue.global(qos: .utility).asyncAfter(deadline: .now() + 0.5) {
            self.networkService.addTask(task) { result in
                self.updateActivityIndicator(state: false)
                do {
                    let task = try result.get()
                    self.dataService.addTasks([task])
                    DispatchQueue.main.async {
                        self.update()
                    }
                } catch {
                    print(error)
                }
            }
        }
    }
    
    func deleteTaskById(_ id: String) {
        updateActivityIndicator(state: true)
        DispatchQueue.global(qos: .utility).asyncAfter(deadline: .now() + 0.5) {
            self.networkService.deleteTask(id: id) { error in
                self.updateActivityIndicator(state: false)
                if let error = error {
                    debugPrint(error)
                } else {
                    self.dataService.removeTaskById(id)
                    DispatchQueue.main.async {
                        self.update()
                    }
                }
            }
        }
    }
}
