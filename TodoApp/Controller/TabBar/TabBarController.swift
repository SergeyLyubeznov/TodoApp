//
//  TabBarController.swift
//  TodoApp
//
//  Created by Serhii Liubeznov on 05.03.2023.
//

import UIKit

enum TabBarType {
    case tasks
    case profile
    
    var title: String {
        switch self {
        case .tasks:
            return Constants.TabBarTitle.Tasks
        case .profile:
            return Constants.TabBarTitle.Profile
        }
    }
    
    var icon: String {
        switch self {
        case .tasks:
            return Constants.TabBarIcon.Tasks
        case .profile:
            return Constants.TabBarIcon.Profile
        }
    }
    
    var selectedIcon: String {
        switch self {
        case .tasks:
            return Constants.TabBarSelectedIcon.Tasks
        case .profile:
            return Constants.TabBarSelectedIcon.Profile
        }
    }
}

class TabBarController: UITabBarController, Storyboarded {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    private func setupUI() {
        tabBar.tintColor = .init(hex: Constants.Colors.TabBarTintColor)
    }
}
