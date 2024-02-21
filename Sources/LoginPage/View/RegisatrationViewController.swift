//
//  RegisatrationViewController.swift
//  
//
//  Created by Yash Chouhan on 20/02/24.
//

import UIKit

public class RegisatrationViewController: UIViewController {

    @IBOutlet private weak var emailView: UIView!
    @IBOutlet private weak var passwordView: UIView!
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var registrationButton: UIButton!
    
    private var registrationViewModel: RegistrationViewModelProtocol
    public var setupForgotController: (() -> ForgotPasswordViewController?)? = nil
    
    public init(viewModel: RegistrationViewModelProtocol) {
        self.registrationViewModel = viewModel
        super.init(nibName: "RegisatrationViewController", bundle: Bundle.module)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }

}

extension RegisatrationViewController {
    @IBAction private func backButtonTapped(_ sender: UIButton) {
        goBack()
    }
    
    @IBAction private func registerNewUser(_ sender: UIButton) {
        
    }
    
    @IBAction private func loginButtonTap(_ sender: UIButton) {
        goBack()
    }
    
    @IBAction private func forgotPassword(_ sender: UIButton) {
        goToController(controller: setupForgotController?())
    }
}


extension RegisatrationViewController {
    private func configure() {
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
        registrationButton.cornerRadius(radius: 10)
        emailTextField.setPlaceholderText(registrationViewModel.emailPlaceholder)
        passwordTextField.setPlaceholderText(registrationViewModel.passwordPlaceholder)
        emailTextField.setPlaceholderColor(registrationViewModel.emailPlaceholderColor)
        passwordTextField.setPlaceholderColor(registrationViewModel.passwordPlaceholderColor)
    }
    
    private func configureTFDelegate() {
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
}

extension RegisatrationViewController: UITextFieldDelegate {
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard textField == passwordTextField else {
            return true
        }
        let currentCharacterCount = textField.text?.count ?? 0
        if range.length + range.location > currentCharacterCount {
            return false
        }
        let newLength = currentCharacterCount + string.count - range.length
        return newLength <= registrationViewModel.setPasswordLimit()
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
