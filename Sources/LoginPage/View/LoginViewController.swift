//
//  LoginViewController.swift
//
//
//  Created by Yash Chouhan on 19/02/24.
//

import UIKit

public class LoginViewController: UIViewController {
    
    @IBOutlet private weak var emailView: UIView!
    @IBOutlet private weak var passwordView: UIView!
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var logionButton: UIButton!
    @IBOutlet private weak var passwordTextField: UITextField!
    
    private var loginViewModel: LoginViewModelProtocol
    public var forgotController: ForgotPasswordViewController? = nil
    public var registrationController: RegisatrationViewController? = nil
    private var passwordLimit: Int = 8
    
    public init(viewModel: LoginViewModelProtocol) {
        self.loginViewModel = viewModel
        super.init(nibName: "LoginViewController", bundle: Bundle.module)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.configure()
    }
}

extension LoginViewController {
    private func configure() {
        passwordLimit = loginViewModel.setPasswordLimit()
        configureViewUI()
        configureTFDelegate()
    }
    
    private func configureViewUI() {
        emailView.cornerRadius(radius: 10)
        emailView.borderWidth(width: 2)
        emailView.borderColor(color: .gray)
        passwordView.cornerRadius(radius: 10)
        passwordView.borderWidth(width: 2)
        passwordView.borderColor(color: .gray)
        logionButton.cornerRadius(radius: 10)
        emailTextField.setPlaceholderText(loginViewModel.emailPlaceholder)
        passwordTextField.setPlaceholderText(loginViewModel.passwordPlaceholder)
        emailTextField.setPlaceholderColor(loginViewModel.emailPlaceholderColor)
        passwordTextField.setPlaceholderColor(loginViewModel.passwordPlaceholderColor)
    }
    
    private func configureTFDelegate() {
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
}

extension LoginViewController {
    @IBAction private func loginButtonTap(_ sender: UIButton) {
        if let error = loginViewModel.isValid(email: emailTextField.text ?? "", password: passwordTextField.text ?? "") {
            alert(error: error)
            return
        }
        loginViewModel.loginTap { [weak self] result in
            switch result {
            case let .success(model):
                print("Success")
                self?.loginViewModel.onSuccess(model: model)
            case let .failure(error):
                print("Failed")
                self?.alert(error: error)
                self?.loginViewModel.onFailure()
            }
        }
    }
    
    @IBAction private func forgotPassword(_ sender: UIButton) {
        goToController(controller: forgotController)
    }
    
    @IBAction private func registerNewUser(_ sender: UIButton) {
        goToController(controller: registrationController)
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
