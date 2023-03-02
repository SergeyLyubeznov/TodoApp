//
//  UIVIew + Utils.swift
//  TestShopFirebase
//
//  Created by Serhii Liubeznov on 10.02.2023.
//

import UIKit

protocol Xibed {
    static var xibName: String { get }
    static func instantiate() -> Self
}

extension Xibed where Self: UIView {
    static var xibName: String {
        return String(describing: Self.self)
    }
    
    static func instantiate() -> Self {
        let xib = UINib(nibName: xibName, bundle: nil)
        guard let view = xib.instantiate(withOwner: nil).first as? Self else {
            fatalError("Unable to Instantiate View: name - \(xibName)")
        }
        return view
    }
}
