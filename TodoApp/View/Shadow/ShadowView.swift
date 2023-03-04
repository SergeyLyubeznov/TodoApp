//
//  ShadowView.swift
//  TodoApp
//
//  Created by Serhii Liubeznov on 04.03.2023.
//

import UIKit

class ShadowView: UIView {
    
    private var shadowLayer: CAShapeLayer?
    private let cornerRadius: CGFloat = 11
    private let fillColor: UIColor  = .white
    private let strokeColor: UIColor = .clear
    private let shadowColor: UIColor = .init(hex: "8A817C")
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if let shadowLayer = shadowLayer {
            shadowLayer.removeFromSuperlayer()
        }
         shadowLayout()
    }

    private func shadowLayout() {
        
        let shadowLayer = CAShapeLayer()
        shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath
        
        shadowLayer.fillColor = fillColor.cgColor
        shadowLayer.borderWidth = 1.0
        shadowLayer.strokeColor = strokeColor.cgColor
        shadowLayer.shadowColor = shadowColor.cgColor
        shadowLayer.shadowPath = shadowLayer.path
        shadowLayer.shadowOffset = CGSize(width: 0.0, height: 0.3)
        shadowLayer.shadowOpacity = 0.1
        shadowLayer.shadowRadius = 4.0

        layer.insertSublayer(shadowLayer, at: 0)
        self.shadowLayer = shadowLayer
    }
}
