//
//  EventListInteractor.swift
//  VIP
//
//  Created by Filipe Rosa
//

import Foundation

protocol EventListInteractor: AnyObject {
    func getEventList(_ resquest: EventListModel.Request)
}

class EventListInteractorImplementation {
    
    // MARK: - Private Properties

    private var presenter: EventListPresenter
    private var eventWorker: EventListWorkerProtocol
    
    // MARK: - Init

    init(_ presenter: EventListPresenter, _ eventWorker: EventListWorkerProtocol = EventListWorker()) {
        self.presenter = presenter
        self.eventWorker = eventWorker
    }
}

//MARK: EventListInteractor

extension EventListInteractorImplementation: EventListInteractor {
    func getEventList(_ resquest: EventListModel.Request) {
        eventWorker.getEventList { (events) in

            let response = EventListModel.Response(events: events)
            self.presenter.interactor(didSuccessGetEventDetail: response)
        } fail: { (message) in
            self.presenter.interactor(didFailGetEventDetail: message)
        }
    }
}
