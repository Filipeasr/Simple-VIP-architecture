//
//  LoginRouter.swift
//  VIP
//
//  Created by Filipe Rosa
//

import UIKit

protocol LoginRouter: AnyObject {
    func routeToEventList(with id: String)
}

class LoginRouterImplementation: LoginRouter {
    
    weak var viewController: UIViewController?
    
    func routeToEventList(with username: String) {
        let eventListViewController = EventListViewController.loadFromNib()
        
        eventListViewController.title = username
        
        EventListConfigurator.configure(viewController: eventListViewController)
        
        viewController?.navigationController?.setViewControllers([eventListViewController], animated: true)
    }
}

