//
//  RegisatrationViewController.swift
//  
//
//  Created by Yash Chouhan on 20/02/24.
//

import UIKit

public class RegisatrationViewController: UIViewController {

    private var viewModel: RegistrationViewModelProtocol
    
    public init(viewModel: RegistrationViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: "RegisatrationViewController", bundle: Bundle.module)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
    }

}
