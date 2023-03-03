//
//  UITextField + Utils.swift
//  TodoApp
//
//  Created by Serhii Liubeznov on 28.02.2023.
//

import UIKit
import Combine

extension UITextField {
    var textPublisher: AnyPublisher<String, Never> {
        NotificationCenter.default
            .publisher(for: UITextField.textDidChangeNotification, object: self)
            .compactMap {$0.object as? UITextField }
            .map {$0.text ?? "" }
            .eraseToAnyPublisher()
    }
}
