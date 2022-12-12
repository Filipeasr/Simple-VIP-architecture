//
//  EventListInteractorTest.swift
//  VIPTests
//
//  Created by Filipe Rosa.
//

@testable import VIP
import XCTest

class EventListInteractorTest: XCTestCase {
    
    // MARK: - Subject under test
    
    var sut: EventListInteractorImplementation!
    
    // MARK: - Test lifecycle
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: - Test doubles
    
    class EventListPresenterSpy: EventListPresenter {

        // MARK: Method call expectations
        
        var presentLoginSuccessCalled = false
        var presentLoginFailCalled = false
        
        // MARK: Argument expectations

        var responseTest: EventListModel.Response!
        
        // MARK: Spied methods
        
        func interactor(didSuccessGetEventDetail response: EventListModel.Response) {
            presentLoginSuccessCalled = true
            responseTest = response
        }
        
        func interactor(didFailGetEventDetail error: String) {
            presentLoginFailCalled = true
        }
        
    }
    
    class EventListWorkerSuccessSpy: EventListWorkerProtocol {
        // MARK: Method call expectations
        
        var eventListSuccessCalled = false
        
        // MARK: Spied methods
        func getEventList(success: @escaping ([String]) -> (), fail:@escaping (String) -> ()) {
            eventListSuccessCalled = true
            success(Seeds.Events.all)
        }
    }
    
    class EventListWorkerFailSpy: EventListWorkerProtocol {
        // MARK: Method call expectations
        
        var eventListFailCalled = false
        
        // MARK: Spied methods
        func getEventList(success: @escaping ([String]) -> (), fail:@escaping (String) -> ()) {
            eventListFailCalled = true
            fail("error")
        }
    }
  
    // MARK: - Test Event List
    
    func testGetAllEventListWithSuccess() {
        // Given
        let eventListPresenterSpy = EventListPresenterSpy()
        let eventListWorkerSpy = EventListWorkerSuccessSpy()

        sut = EventListInteractorImplementation(eventListPresenterSpy, eventListWorkerSpy)
        
        // When
        let request = EventListModel.Request()
        sut.getEventList(request)
        
        // Then
        let response = eventListPresenterSpy.responseTest
        
        XCTAssertEqual(response?.events.count, 3, "Event list count response should be 3")
        XCTAssert(eventListWorkerSpy.eventListSuccessCalled, "getEventList should ask EventListWorker to fetch events")
        XCTAssert(eventListPresenterSpy.presentLoginSuccessCalled, "getEventList() should ask presenter to format events result")
    }
    
    func testGetAllEventListWithFail() {
        // Given
        let eventListPresenterSpy = EventListPresenterSpy()
        let eventListWorkerSpy = EventListWorkerFailSpy()

        sut = EventListInteractorImplementation(eventListPresenterSpy, eventListWorkerSpy)
        
        // When
        let request = EventListModel.Request()
        sut.getEventList(request)
        
        // Then
        XCTAssert(eventListWorkerSpy.eventListFailCalled, "getEventList should ask EventListWorker to fetch events")
        XCTAssert(eventListPresenterSpy.presentLoginFailCalled, "getEventList() should ask presenter to format events result")
    }
    
}
