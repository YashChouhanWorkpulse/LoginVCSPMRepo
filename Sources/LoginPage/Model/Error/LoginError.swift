//
//  LoginError.swift
//  
//
//  Created by Yash Chouhan on 20/02/24.
//

import Foundation

public enum LoginError: Error, ErrorTitleMessageProtocol {
    case emptyPassword
    case emptyEmail
    case invalidPassword
    case invalidEmail
    case custom(String)
    
    public var message: String {
        switch self {
        case .emptyPassword:
            return "Password is empty"
        case .emptyEmail:
            return "email is empty"
        case .invalidPassword:
            return "invalid password"
        case .invalidEmail:
            return "invalid email"
        case .custom(let message):
            return message
        }
    }
    
    public var title: String {
        return "Error"
    }
}
