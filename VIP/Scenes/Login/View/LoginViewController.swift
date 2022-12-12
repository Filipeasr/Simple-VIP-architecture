//
//  LoginViewController.swift
//  VIP
//
//  Created by Filipe Rosa
//

import UIKit

protocol LoginPresenterOutput: AnyObject {
    func presenter(didSuccessLogin viewModel: LoginModel.ViewModel)
    func presenter(didFailLogin message: String)
}

class LoginViewController: UIViewController {
    
    // MARK: - Public Properties
    
    var interactor: LoginInteractor?
	var router: LoginRouter?
    
    // MARK: - IBOutlet

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var errorMessageLabel: UILabel!
    
    // MARK: - Override
    
	override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK: - Action
    
    @IBAction func loginAction(_ sender: Any) {
        errorMessageLabel.text = ""
        let request = LoginModel.Request(username: usernameTextField.text ?? "", password: passwordTextField.text ?? "")
        interactor?.login(request)
    }
}

// MARK: LoginPresenterOutput

extension LoginViewController: LoginPresenterOutput {
    func presenter(didSuccessLogin viewModel: LoginModel.ViewModel) {
        router?.routeToEventList(with: viewModel.fullTitle)
    }
    
    func presenter(didFailLogin message: String) {
        errorMessageLabel.text = message
    }
}
