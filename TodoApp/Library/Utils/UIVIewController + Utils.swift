//
//  UIVIewController + Utils.swift
//  Test
//
//  Created by Serhii Liubeznov on 08.02.2023.
//

import UIKit

extension UIViewController {
    func dismiss(animation: Bool = true) {
        self.dismiss(animated: animation)
    }
}

protocol Storyboarded {
    static var storyboardName: String { get }
    static func instantiate() -> Self
}

extension Storyboarded where Self: UIViewController {
    
    static var storyboardName: String {
        return "Main"
    }
    
    static func instantiate() -> Self {
        let id = String(describing: self)
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        guard let controller = storyboard.instantiateViewController(withIdentifier: id) as? Self else {
            fatalError("Unable to Instantiate View Controller: id - \(id), sb - \(storyboard)")
        }
        return controller
    }
}

extension UIViewController {
    func showErrorAlert(error: Error) {
        let alert = UIAlertController(title: "Error", message: error.localizedDescription,
                                      preferredStyle: UIAlertController.Style.alert)
        let action = UIAlertAction(title: "Ok", style: .default) { _ in
            alert.dismiss()
        }
        
        alert.addAction(action)
        
        self.present(alert, animated: true)
    }
}
