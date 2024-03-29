//
//  RegistrationError.swift
//  
//
//  Created by Yash Chouhan on 21/02/24.
//

import Foundation


public enum RegistrationError: Error, ErrorTitleMessageProtocol {
    case emptyEmail
    case invalidEmail
    case notRegisterAtYet
    case custom(String)
    
    public var message: String {
        switch self {
        case .emptyEmail:
            return "email is empty"
        case .invalidEmail:
            return "invalid email"
        case .custom(let message):
            return message
        case .notRegisterAtYet:
            return "This email is not register at yet"
        }
    }
    
    public var title: String {
        return "Error"
    }
}
