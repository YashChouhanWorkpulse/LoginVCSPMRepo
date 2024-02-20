//
//  LoginViewModelProtocol.swift
//  
//
//  Created by Yash Chouhan on 20/02/24.
//

import Foundation
import UIKit

public protocol LoginViewModelProtocol {
    var emailPlaceholder: String { get set }
    var passwordPlaceholder: String { get set }
    var emailPlaceholderColor: UIColor { get set }
    var passwordPlaceholderColor: UIColor { get set }
    func setPasswordLimit() -> Int
    func isValid(email: String,password: String) -> LoginError?
    func loginTap(completion: @escaping (Result<Encodable, LoginError>) -> Void)
    func onSuccess(model: Encodable)
    func onFailure()
}
