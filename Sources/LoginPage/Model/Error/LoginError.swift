//
//  File.swift
//  
//
//  Created by Yash Chouhan on 20/02/24.
//

import Foundation

public enum LoginError: Error {
    case emptyPassword
    case emaptyEmail
    case invalidPassword
    case invalidEmail
    case customO(String)
    
    var message: String {
        switch self {
        case .emptyPassword:
            return "Password is empty"
        case .emaptyEmail:
            return "email is empty"
        case .invalidPassword:
            return "invalid password"
        case .invalidEmail:
            return "invalid email"
        case .customO(let message):
            return message
        }
    }
    
    var title: String {
        return "Error"
    }
}
