//
//  EventListRouter.swift
//  VIP
//
//  Created by Filipe Rosa
//

import UIKit

protocol EventListRouter: AnyObject {
    func routeToEventDetail(_ username: String)
}

class EventListRouterImplementation: EventListRouter {
    
    weak var viewController: UIViewController?
    
    func routeToEventDetail(_ username: String) {
        let eventDetailViewController = EventDetailViewController.loadFromNib()

        eventDetailViewController.title = username
        
        EventDetailConfigurator.configure(viewController: eventDetailViewController)
        viewController?.navigationController?.pushViewController(eventDetailViewController, animated: true)
    }
}
