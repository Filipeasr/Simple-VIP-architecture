//
//  EventDetailModel.swift
//  VIP
//
//  Created by Filipe Rosa
//

import Foundation

struct EventDetailModel {
    
    // MARK: - Request

    struct Request {
        var parameters: [String: Any]? {
            // do someting...
            return nil
        }
    }
    
    // MARK: - Response

    struct Response {
        var event: Event
    }
    
    // MARK: - ViewModel

    struct ViewModel {
        var name: String
        var description: String
        var startDate: String
        var endDate: String
    }
}
