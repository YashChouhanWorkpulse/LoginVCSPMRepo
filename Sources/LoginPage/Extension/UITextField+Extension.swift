//
//  UITextField+Extension.swift
//  
//
//  Created by Yash Chouhan on 20/02/24.
//

import UIKit

public extension UITextField {
    func setPlaceholderColor(_ color: UIColor) {
        guard let placeholder = placeholder else { return }
        let attributes = [NSAttributedString.Key.foregroundColor: color]
        attributedPlaceholder = NSAttributedString(string: placeholder, attributes: attributes)
    }
    
    func setPlaceholderText(_ placeholder: String) {
        attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [:])
    }
}
