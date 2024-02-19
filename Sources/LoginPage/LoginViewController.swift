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
        return ""
    }
    
    var title: String {
        return "Error"
    }
}


public protocol LoginViewModelProtocol {
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
    @IBOutlet private weak var passwordTextField: UITextField!
    
    private var viewModel: LoginViewModelProtocol
    private var passwordLimit: Int = 8

    init(viewModel: LoginViewModelProtocol) {
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
                self?.viewModel.onSuccess(model: model)
            case let .failure(error):
                self?.alert(error: error)
                self?.viewModel.onFailure()
            }
        }
    }
    
    
    private func configureViewUI() {
        emailView.cornerRadius(radius: 10).borderWidth(width: 2).borderColor(color: .gray)
        passwordView.cornerRadius(radius: 10).borderWidth(width: 2).borderColor(color: .gray)
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
}




extension UIView {
    @discardableResult
    func cornerRadius(radius: CGFloat) -> UIView {
        self.layer.cornerRadius = radius
        return self
    }
    
    @discardableResult
    func borderWidth(width: CGFloat) -> UIView {
        self.layer.borderWidth = width
        return self
    }
    
    @discardableResult
    func borderColor(color: UIColor) -> UIView {
        self.layer.borderColor = color.cgColor
        return self
    }
}
