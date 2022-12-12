//
//  EventDetailWorker.swift
//  VIP
//
//  Created by Filipe Rosa
//

import Foundation

protocol EventDetailWorkerProtocol {
    func getEventDetail(success: @escaping(Event) -> (), fail:@escaping(String) -> ())
}

class EventDetailWorker: EventDetailWorkerProtocol {
    func getEventDetail(success: @escaping(Event) -> (), fail:@escaping(String) -> ()) {
        let service = EventServiceImplementation()
        
        service.getEventDetail { (event) in
            success(event)
        } fail: { (message) in
            fail(message)
        }
    }
}
