//
//  ForgotPasswordViewController.swift
//  
//
//  Created by Yash Chouhan on 20/02/24.
//

import UIKit

public class ForgotPasswordViewController: UIViewController {

    @IBOutlet private weak var forgotEmailView: UIView!
    @IBOutlet private weak var forgotTextField: UITextField!
    @IBOutlet private weak var logoImageView: UIImageView!
    @IBOutlet private weak var sendButton: UIButton!
    
    private var viewModel: ForogotPassowrdViewModelProtocol
    
    public init(viewModel: ForogotPassowrdViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: "ForgotPasswordViewController", bundle: Bundle.module)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.configure()
    }
}

extension ForgotPasswordViewController {
    @IBAction private func backButtonTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction private func sendButtonTapped(_ sender: UIButton) {
        if let error = viewModel.isValidEmail(email: forgotTextField.text ?? "") {
            alert(error: error)
            return
        }
        viewModel.sendForgotPasswordLinkOnEmail { [weak self] result in
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
}

extension ForgotPasswordViewController {
    private func configure() {
        configureViewUI()
        configureTFDelegate()
    }
    
    private func configureViewUI() {
        forgotEmailView.cornerRadius(radius: 10)
        forgotEmailView.borderWidth(width: 2)
        forgotEmailView.borderColor(color: .gray)
        sendButton.cornerRadius(radius: 10)
        forgotTextField.setPlaceholderText(viewModel.emailPlaceholder)
        forgotTextField.setPlaceholderColor(viewModel.emailPlaceholderColor)
        logoImageView.cornerRadius(radius: logoImageView.frame.width * 0.5)
        logoImageView.tintColor = .white
        logoImageView.backgroundColor = UIColor.systemBlue
    }
    
    private func configureTFDelegate() {
        forgotTextField.delegate = self
    }
}

extension ForgotPasswordViewController: UITextFieldDelegate {}
