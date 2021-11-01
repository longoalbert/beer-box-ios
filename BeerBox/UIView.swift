//
//  UIView.swift
//  BeerBox
//
//  Created by Alberto Longo on 31/10/21.
//

import Foundation
import UIKit


public extension UIView {
    
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let roundedLayer = CAShapeLayer()
        roundedLayer.path = UIBezierPath(
            roundedRect: bounds,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
            ).cgPath
        layer.mask = roundedLayer
    }
    
}
