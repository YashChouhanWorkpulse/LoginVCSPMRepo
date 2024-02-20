//
//  LoginViewController.swift
//
//
//  Created by Yash Chouhan on 19/02/24.
//

import UIKit

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

public class LoginViewController: UIViewController {
    
    @IBOutlet private weak var emailView: UIView!
    @IBOutlet private weak var passwordView: UIView!
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet weak var logionButton: UIButton!
    @IBOutlet private weak var passwordTextField: UITextField!
    
    private var viewModel: LoginViewModelProtocol
    private var passwordLimit: Int = 8
    
    public init(viewModel: LoginViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: "LoginViewController", bundle: Bundle.module)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.configure()
    }
    
    private func configure() {
        passwordLimit = viewModel.setPasswordLimit()
        configureViewUI()
        configureTFDelegate()
    }
    
    @IBAction private func loginButtonTap(_ sender: UIButton) {
        if let error = viewModel.isValid(email: emailTextField.text ?? "", password: passwordTextField.text ?? "") {
            alert(error: error)
            return
        }
        viewModel.loginTap { [weak self] result in
            switch result {
            case let .success(model):
                print("Success")
                self?.viewModel.onSuccess(model: model)
            case let .failure(error):
                print("Failed")
                self?.alert(error: error)
                self?.viewModel.onFailure()
            }
        }
    }
    
    
    private func configureViewUI() {
        emailView.cornerRadius(radius: 10)
        emailView.borderWidth(width: 2)
        emailView.borderColor(color: .gray)
        passwordView.cornerRadius(radius: 10)
        passwordView.borderWidth(width: 2)
        passwordView.borderColor(color: .gray)
        logionButton.cornerRadius(radius: 10)
        emailTextField.setPlaceholderText(viewModel.emailPlaceholder)
        passwordTextField.setPlaceholderText(viewModel.passwordPlaceholder)
        emailTextField.setPlaceholderColor(viewModel.emailPlaceholderColor)
        passwordTextField.setPlaceholderColor(viewModel.passwordPlaceholderColor)
    }
    
    private func configureTFDelegate() {
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    private func alert(error: LoginError) {
        let alertVC = UIAlertController(title: error.title,
                                        message: error.message,
                                        preferredStyle: .alert)
        let okAction = UIAlertAction.init(title: "Ok", style: .default) { _ in
            
        }
        alertVC.addAction(okAction)
        self.present(alertVC, animated: true)
    }
    
}

extension LoginViewController: UITextFieldDelegate {
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard textField == passwordTextField else {
            return true
        }
        let currentCharacterCount = textField.text?.count ?? 0
        if range.length + range.location > currentCharacterCount {
            return false
        }
        let newLength = currentCharacterCount + string.count - range.length
        return newLength <= passwordLimit
    }
    
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case emailTextField:
            passwordTextField.becomeFirstResponder()
        case passwordTextField:
            emailTextField.becomeFirstResponder()
        default:
            break
        }
        return true
        
    }
}




extension UIView {
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

extension UITextField {
    func setPlaceholderColor(_ color: UIColor) {
        guard let placeholder = placeholder else { return }
        let attributes = [NSAttributedString.Key.foregroundColor: color]
        attributedPlaceholder = NSAttributedString(string: placeholder, attributes: attributes)
    }
    
    func setPlaceholderText(_ placeholder: String) {
        attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [:])
    }
}
