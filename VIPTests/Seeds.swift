//
//  Seeds.swift
//  VIPTests
//
//  Created by Filipe Rosa.
//

@testable import VIP
import UIKit

struct Seeds {
    struct Events {
        static let eventA = "Event A"
        static let eventB = "Event B"
        static let eventC = "Event C"
        
        static let all = [eventA, eventB, eventC]
    }
    
    struct EventDetail {
        static let eventA = Event(name: "Event A", description: "Description A", startDate: Date.from(year: 1815, month: 12, day: 10)!, endDate: Date.from(year: 1852, month: 11, day: 27)!)
        static let eventB = Event(name: "Event B", description: "Description B", startDate: Date.from(year: 2020, month: 06, day: 02)!, endDate: Date.from(year: 2020, month: 06, day: 05)!)
    }
    
    struct UserLogin {
        static let userApollo11 = User(firstName: "Margaret", lastName: "Hamilton", genre: "feminino")
        static let userUncleBob = User(firstName: "Robert", lastName: "Martin", genre: "masculino")
    }
}
