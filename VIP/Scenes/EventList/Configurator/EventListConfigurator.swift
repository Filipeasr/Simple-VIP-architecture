//
//  EventListConfigurator.swift
//  VIP
//
//  Created by Filipe Rosa
//

import UIKit

class EventListConfigurator {
    
    static func configure(viewController: EventListViewController) {
        let router = EventListRouterImplementation()
        let presenter = EventListPresenterImplementation(viewController)
        let interactor = EventListInteractorImplementation(presenter)
        
        viewController.router = router
        viewController.interactor = interactor
        
        router.viewController = viewController
    }
}
