//
//  EventDetailPresenter.swift
//  VIP
//
//  Created by Filipe Rosa
//

import Foundation

protocol EventDetailPresenter: AnyObject {
    func interactor(didSuccessGetEventDetail response: EventDetailModel.Response)
    func interactor(didFailGetEventDetail error: String)
}

class EventDetailPresenterImplementation {
    
    // MARK: - Private Properties

    private weak var viewController: EventDetailPresenterOutput?
    
    // MARK: - Init

    init(_ viewController: EventDetailPresenterOutput) {
        self.viewController = viewController
    }
}

// MARK: - EventDetailPresenter

extension EventDetailPresenterImplementation: EventDetailPresenter {
    func interactor(didSuccessGetEventDetail response: EventDetailModel.Response) {
        let event = response.event
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YY/MM/dd"
        
        let viewModel = EventDetailModel.ViewModel(name: event.name,
                                                   description: event.description,
                                                   startDate: dateFormatter.string(from: event.startDate),
                                                   endDate: dateFormatter.string(from: event.endDate))

        viewController?.presenter(didSuccessGetEventDetail: viewModel)
    }

    func interactor(didFailGetEventDetail error: String) {
        viewController?.presenter(didFailGetEventDetail: error)
    }
}
