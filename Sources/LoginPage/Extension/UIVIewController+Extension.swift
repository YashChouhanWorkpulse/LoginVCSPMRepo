//
//  UIVIewController+Extension.swift
//  
//
//  Created by Yash Chouhan on 20/02/24.
//

import Foundation
import UIKit

public extension UIViewController {
    func alert(error: ErrorTitleMessageProtocol) {
        let alertVC = UIAlertController(title: error.title,
                                        message: error.message,
                                        preferredStyle: .alert)
        let okAction = UIAlertAction.init(title: "Ok", style: .default) { _ in
            
        }
        alertVC.addAction(okAction)
        self.present(alertVC, animated: true)
    }
}
