//
//  BaseViewController.swift
//  TodoApp
//
//  Created by Serhii Liubeznov on 02.03.2023.
//

import UIKit

class BaseViewController: UIViewController {
    #if DEBUG
    deinit {
        print("Deinit - \(String(describing: self))")
    }
    #endif
}
