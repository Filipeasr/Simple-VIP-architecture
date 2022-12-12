//
//  EventDetailConfigurator.swift
//  VIP
//
//  Created by Filipe Rosa
//

import UIKit

class EventDetailConfigurator {
    
    static func configure(viewController: EventDetailViewController) {
        let router = EventDetailRouterImplementation()
        let presenter = EventDetailPresenterImplementation(viewController)
        let interactor = EventDetailInteractorImplementation(presenter)
        
        viewController.router = router
        viewController.interactor = interactor
        
        router.viewController = viewController
    }
}
