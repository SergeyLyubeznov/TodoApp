//
//  AppCoordinator.swift
//  TodoApp
//
//  Created by Serhii Liubeznov on 01.03.2023.
//

import UIKit

protocol BaseCoordinator {
    func initialViewController() -> UIViewController
}

protocol Coordinator: AnyObject {
    associatedtype Destination
    func show(_ destination: Destination)
}

protocol BackCoordinator: Coordinator {
    func back()
}

class AppCoordinator {
    
    static let shared = AppCoordinator()
    
    let window: UIWindow
    private var coordinators: [any Coordinator] = []
    private let tokenService: TokenService
    private let dataService: BaseDataService
    private let controller: UINavigationController
    
    private init() {
        tokenService = TokenKeychanService()
        dataService = CoreDataService.shared
        window = UIWindow()
        self.controller = BaseNavigationController()
        window.rootViewController = controller
        window.makeKeyAndVisible()
        start()
    }
    
    func start() {
        if let token = tokenService.read() {
            show(.main(token: token))
        } else {
            show(.login)
        }
    }
}

extension AppCoordinator: Coordinator {
    enum Destination {
        case login
        case main(token: String)
    }
    
    func show(_ destination: Destination) {
        switch destination {
        case .login:
            showLoginFlow()
        case .main(let token):
            showMainFlow(token: token)
        }
    }
    
    private func showLoginFlow() {
        let coordinator = LoginCoordinator(controller: controller)
        coordinator.coordinatorClose = {[weak self] in
            guard let self = self else {return}
            self.coordinators.removeAll()
            self.controller.viewControllers.removeAll()
            self.start()
        }
        self.coordinators.append(coordinator)
    }

    private func showMainFlow(token: String) {
        let coordinator = MainCoordinator(controller: controller, token: token)
        coordinator.coordinatorClose = {[weak self] in
            guard let self = self else {return}
            self.tokenService.delete()
            self.dataService.removeAll()
            self.coordinators.removeAll()
            self.controller.viewControllers.removeAll()
            self.start()
        }
        self.coordinators.append(coordinator)
    }
}
