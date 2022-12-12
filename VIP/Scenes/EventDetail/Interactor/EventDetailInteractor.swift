//
//  EventDetailInteractor.swift
//  VIP
//
//  Created by Filipe Rosa
//

import Foundation

protocol EventDetailInteractor: AnyObject {
    func getEventDetail()
}

class EventDetailInteractorImplementation {
    
    // MARK: - Private Properties

    private var presenter: EventDetailPresenter
    private var eventDetailWorker: EventDetailWorkerProtocol
    
    // MARK: - Init

    init(_ presenter: EventDetailPresenter, _ eventDetailWorker: EventDetailWorkerProtocol = EventDetailWorker()) {
        self.presenter = presenter
        self.eventDetailWorker = eventDetailWorker
    }
}

//MARK: EventDetailInteractor

extension EventDetailInteractorImplementation: EventDetailInteractor {
    func getEventDetail() {
        eventDetailWorker.getEventDetail { (event) in
            let response = EventDetailModel.Response(event: event)
            self.presenter.interactor(didSuccessGetEventDetail: response)
        } fail: { (message) in
            self.presenter.interactor(didFailGetEventDetail: message)
        }
    }
}

