//
//  File.swift
//  
//
//  Created by Yash Chouhan on 20/02/24.
//

import Foundation
import UIKit

public protocol RegistrationViewModelProtocol {
    
    var emailPlaceholder: String { get set }
    var passwordPlaceholder: String { get set }
    var emailPlaceholderColor: UIColor { get set }
    var passwordPlaceholderColor: UIColor { get set }
    func setPasswordLimit() -> Int
    func isValid(email: String,password: String) -> RegistrationError?
    func registractionTap(completion: @escaping (Result<Encodable, RegistrationError>) -> Void)
    func onSuccess(model: Encodable)
    func onFailure()
}
