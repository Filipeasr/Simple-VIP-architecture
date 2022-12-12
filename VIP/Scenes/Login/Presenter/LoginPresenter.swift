//
//  LoginPresenter.swift
//  VIP
//
//  Created by Filipe Rosa
//

import UIKit

protocol LoginPresenter: AnyObject {
    func interactor(didSuccessLogin response: LoginModel.Response)
    func interactor(didFailLogin error: String)
}

class LoginPresenterImplementation {

    // MARK: - Private Properties

    private weak var viewController: LoginPresenterOutput?

    // MARK: - Init

    init(_ viewController: LoginPresenterOutput?) {
        self.viewController = viewController
    }
}

// MARK: - LoginPresenter

extension LoginPresenterImplementation: LoginPresenter {
    func interactor(didSuccessLogin response: LoginModel.Response) {
        
        //presenting logica
        let fullName = "\(response.user.firstName) \(response.user.lastName)"
        let title = response.title
        
        let viewModel = LoginModel.ViewModel(fullTitle: "\(title) \(fullName)")
        
        viewController?.presenter(didSuccessLogin: viewModel)
    }
    
    func interactor(didFailLogin error: String) {
        viewController?.presenter(didFailLogin: error)
    }
}
