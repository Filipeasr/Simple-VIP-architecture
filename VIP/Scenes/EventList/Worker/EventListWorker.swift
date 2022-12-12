//
//  EventListWorker.swift
//  VIP
//
//  Created by Filipe Rosa
//

import UIKit

protocol EventListWorkerProtocol {
    func getEventList(success: @escaping ([String]) -> (), fail:@escaping (String) -> ())
}

class EventListWorker: EventListWorkerProtocol {
    
    func getEventList(success: @escaping ([String]) -> (), fail:@escaping (String) -> ()) {
        let service = EventServiceImplementation()
        
        service.getSimpleListOfEvents { (events) in
            DispatchQueue.main.async {
                success(events)
            }
            
        } fail: { (message) in
            DispatchQueue.main.async {
                fail(message)
            }
        }
    }
}
