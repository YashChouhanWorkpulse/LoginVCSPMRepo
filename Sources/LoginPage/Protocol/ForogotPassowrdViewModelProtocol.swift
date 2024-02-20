//
//  ForogotPassowrdViewModelProtocol.swift
//  
//
//  Created by Yash Chouhan on 20/02/24.
//

import Foundation
import UIKit

public protocol ForogotPassowrdViewModelProtocol {
    var emailPlaceholder: String { get set }
    var emailPlaceholderColor: UIColor { get set }
    func isValidEmail(email: String) -> ForgotError?
    func sendForgotPasswordLinkOnEmail(completion: @escaping (Result<Encodable, ForgotError>) -> Void)
    func onSuccess(model: Encodable)
    func onFailure()
}
