//
//  EventListService.swift
//  VIP
//
//  Created by Filipe Rosa
//

import Foundation

protocol EventService: AnyObject {
    func getSimpleListOfEvents(success: @escaping([String]) -> (), fail: @escaping(_ message: String) -> ())
    func getEventDetail(success: @escaping (Event) -> (), fail: @escaping (String) -> ())
}

class EventServiceImplementation: EventService {
    func getSimpleListOfEvents(success: @escaping ([String]) -> (), fail: @escaping (String) -> ()) {
        let events = [
            "Evento A",
            "Evento B"
        ]
        success(events)
    }
    
    func getEventDetail(success: @escaping (Event) -> (), fail: @escaping (String) -> ()) {
        let event = Event(name: "name event", description: "description event", startDate: Date(), endDate: Date())
        
        success(event)
    }
}
