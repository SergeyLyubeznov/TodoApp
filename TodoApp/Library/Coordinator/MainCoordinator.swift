//
//  MainCoordinator.swift
//  TodoApp
//
//  Created by Serhii Liubeznov on 02.03.2023.
//

import UIKit

class MainCoordinator {
    
    var coordinatorClose: (() -> Void)?
    
    private var navigationController: UINavigationController
    private let token: String
    
    init(controller: UINavigationController, token: String) {
        self.navigationController = controller
        self.token = token
        
        let tabBarController = TabBarController.instantiate()
        tabBarController.viewControllers = self.controllers()
        navigationController.pushViewController(tabBarController, animated: true)
    }
    
    #if DEBUG
    deinit {
        print("Deinit - \(String(describing: self))")
    }
    #endif
}

extension MainCoordinator {
    
    private func controllers() -> [UIViewController] {
        
        let types: [TabBarType] = [.tasks, .profile]
        var controllers: [UIViewController] = []
        
        for type in types {
            let controller = controllerAt(type: type)
            controller.tabBarItem = UITabBarItem(title: type.title, image: .init(named: type.icon),
                                                 selectedImage: .init(named: type.selectedIcon))
            controllers.append(controller)
        }
        
        controllers.insert(UIViewController(), at: 1)
        
        return controllers
    }
    
    private func controllerAt(type: TabBarType) -> UIViewController {
        switch type {
        case .tasks:
            let controller = TasksViewController.instantiate()
            let viewModel = TasksViewModel(networkService: TasksNetworkService(accessToken: token))
            controller.coordintator = { [weak self] destination in
                self?.show(destination)
            }
            controller.setViewModel(viewModel)
            return controller
        case .profile:
            let controller = ProfileViewController.instantiate()
            controller.coordintator = { [weak self] destination in
                self?.show(destination)
            }
            return controller
        }
    }
    
    private func showAddTaskViewControllerAt(_ viewModel: TasksViewModel) {
        let controller = AddTaskViewController.instantiate()
        controller.setViewModel(viewModel)
        self.navigationController.present(controller, animated: true)
    }
}

extension MainCoordinator: Coordinator {
    
    enum Destination {
        case back
        case logout
        case addTask(TasksViewModel)
    }
    
    func show(_ destination: Destination) {
        switch destination {
        case .back:
            navigationController.popViewController(animated: true)
        case .logout:
            coordinatorClose?()
        case .addTask(let viewModel):
            showAddTaskViewControllerAt(viewModel)
        }
    }
}
