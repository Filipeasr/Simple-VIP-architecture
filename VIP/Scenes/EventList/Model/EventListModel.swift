//
//  EventListModel.swift
//  VIP
//
//  Created by Filipe Rosa
//

import UIKit

struct EventListModel {

    // MARK: - Request

    struct Request {
        
    }
    
    // MARK: - Response
    
    struct Response {
        var events: [String]
    }
    
    // MARK: - ViewModel
    
    struct ViewModel {
        struct DisplayedEvent {
            var name: String
        }
        
        var displayedEvents: [DisplayedEvent]
        
    }
    
}
