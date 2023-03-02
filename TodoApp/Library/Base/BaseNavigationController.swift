//
//  BaseNavigationController.swift
//  TodoApp
//
//  Created by Serhii Liubeznov on 28.02.2023.
//

import UIKit

class BaseNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationBar.isHidden = true
    }
}
