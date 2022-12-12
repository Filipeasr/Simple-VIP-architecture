//
//  LoginConfigurator.swift
//  VIP
//
//  Created by Filipe Rosa
//

import Foundation

class LoginConfigurator {
    
    static func configure(viewController: LoginViewController) {
        let router = LoginRouterImplementation()
        let presenter = LoginPresenterImplementation(viewController)
        let interactor = LoginInteractorImplementation(presenter)
        
        viewController.router = router
        viewController.interactor = interactor
        
        router.viewController = viewController
    }
}
