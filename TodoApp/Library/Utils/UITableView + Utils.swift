//
//  UITableView + Utils.swift
//  TestShopFirebase
//
//  Created by Serhii Liubeznov on 10.02.2023.
//

import UIKit

extension UITableView {
    func registerCell(_ identifier: String) {
        self.register(.init(nibName: identifier, bundle: nil),
                      forCellReuseIdentifier: identifier)
    }
}

extension UITableViewCell {
    class var identifier: String {
        return String(describing: Self.self)
    }
}
