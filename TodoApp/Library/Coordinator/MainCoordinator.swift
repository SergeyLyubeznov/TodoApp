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
        let controller = TasksViewController.instantiate()
        let viewModel = TasksViewModel(networkService: TasksNetworkService(accessToken: token))
        controller.setViewModel(viewModel)
        controller.coordintator = {self.show($0)}
        navigationController.pushViewController(controller, animated: true)
    }
    
    #if DEBUG
    deinit {
        print("Deinit - \(String(describing: self))")
    }
    #endif
}

extension MainCoordinator: Coordinator {
    enum Destination {
        case back
        case logout
    }
    
    func show(_ destination: Destination) {
        switch destination {
        case .back:
            navigationController.popViewController(animated: true)
        case .logout:
            coordinatorClose?()
        }
    }
}
