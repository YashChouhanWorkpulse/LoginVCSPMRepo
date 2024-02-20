//
//  File.swift
//  
//
//  Created by Yash Chouhan on 20/02/24.
//

import UIKit

public extension UIView {
    func cornerRadius(radius: CGFloat) {
        self.layer.cornerRadius = radius
    }
    
    func borderWidth(width: CGFloat) {
        self.layer.borderWidth = width
    }
    
    func borderColor(color: UIColor) {
        self.layer.borderColor = color.cgColor
    }
}
