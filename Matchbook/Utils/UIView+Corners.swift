//
//  UIView+Corners.swift
//  Matchbook
//
//  Created by Nayely on 08/06/20.
//  Copyright © 2020 Nayely. All rights reserved.
//

import UIKit

extension UIView {
    func setCornerRadius(_ radius: CGFloat, borderColor: UIColor? = nil, borderWidth: CGFloat = 1.0) {
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
        if let color = borderColor?.cgColor {
            self.layer.borderColor = color
            self.layer.borderWidth = borderWidth
        }
    }
    
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
         let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
         let mask = CAShapeLayer()
         mask.path = path.cgPath
         self.layer.mask = mask
    }
    
    class func fromNib(_ name: String) -> Self? {
        return fromNib(name: name, type: self)
    }
    
    private class func fromNib<T: UIView>(name: String, type: T.Type) -> T? {
        return Bundle.main.loadNibNamed(name, owner: nil, options: nil)?[0] as? T
    }
}

