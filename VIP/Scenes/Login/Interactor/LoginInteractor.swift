//
//  LoginConfigurator.swift
//  VIP
//
//  Created by Filipe Rosa
//

import UIKit

protocol LoginInteractor: AnyObject {
    func login(_ request: LoginModel.Request)
}

class LoginInteractorImplementation {
    
    // MARK: - Private Properties
    
    private var presenter: LoginPresenter?
    private var loginWork: LoginWorkerProtocol?
    
    // MARK: - Init
    
    init(_ presenter: LoginPresenter?, _ loginWork: LoginWorkerProtocol? = LoginWorker()) {
        self.presenter = presenter
        self.loginWork = loginWork
    }
}

// MARK: - LoginInteractor

extension LoginInteractorImplementation: LoginInteractor {
    func login(_ request: LoginModel.Request) {
        
        loginWork?.login(username: request.username, password: request.password, success: { (user) in
            
            var response: LoginModel.Response?
            
            //business logic
            if user.genre == "feminino" {
                response = LoginModel.Response(user: user, title: "Mrs")
            } else {
                response = LoginModel.Response(user: user, title: "Mr")
            }
            
            if let response = response {
                self.presenter?.interactor(didSuccessLogin: response)
            }
            
        }, fail: { (message) in
            self.presenter?.interactor(didFailLogin: message)
        })
    }
}
