//
//  EventListPresenter.swift
//  VIP
//
//  Created by Filipe Rosa
//

import UIKit

protocol EventListPresenter: AnyObject {
    func interactor(didSuccessGetEventDetail response: EventListModel.Response)
    func interactor(didFailGetEventDetail error: String)
}

class EventListPresenterImplementation {
    
    // MARK: - Private Properties

    private weak var viewController: EventListPresenterOutput?
    
    // MARK: - Init
    
    init(_ viewController: EventListPresenterOutput) {
        self.viewController = viewController
    }
}

// MARK: - EventListPresenter

extension EventListPresenterImplementation: EventListPresenter {
    func interactor(didSuccessGetEventDetail response: EventListModel.Response) {
        
        var displeyedEvents = [EventListModel.ViewModel.DisplayedEvent]()
        for event in response.events {
            displeyedEvents.append(EventListModel.ViewModel.DisplayedEvent(name: event))
        }
        
        let viewModel = EventListModel.ViewModel(displayedEvents: displeyedEvents)
        
        viewController?.presenter(didSuccessGetEventList: viewModel)
    }
    
    func interactor(didFailGetEventDetail error: String) {
        viewController?.presenter(didFailGetEventList: error)
    }
}
