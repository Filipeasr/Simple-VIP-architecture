//
//  EventDetailInteractorTest.swift
//  VIPTests
//
//  Created by Filipe Rosa.
//

@testable import VIP
import XCTest

class EventDetailInteractorTest: XCTestCase {
    
    // MARK: - Subject under test
    
    var sut: EventDetailInteractorImplementation!
    
    // MARK: - Test lifecycle
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: - Test Mock
    
    class EventDetailPresenterSpy: EventDetailPresenter {
    
        // MARK: Method call expectations
        
        var presentEventDetailCalled = false
        
        // MARK: Argument expectations

        var responseTest: EventDetailModel.Response!
        var errorMessageTest: String!
        
        // MARK: EventDetailPresenter
        
        func interactor(didSuccessGetEventDetail response: EventDetailModel.Response) {
            presentEventDetailCalled = true
            responseTest = response
        }
        
        func interactor(didFailGetEventDetail error: String) {
            presentEventDetailCalled = true
            errorMessageTest = error
        }
    }
    
    class EventDetailSuccessWorkerSpy: EventDetailWorkerProtocol {
        
        // MARK: Method call expectations
        
        var eventDetailCalled = false
        
        // MARK: Spied methods
        func getEventDetail(success: @escaping (Event) -> (), fail: @escaping (String) -> ()) {
            eventDetailCalled = true
            success(Seeds.EventDetail.eventA)
        }
    }

    class EventDetailFaillWorkerSpy: EventDetailWorkerProtocol {
        
        // MARK: Method call expectations
        
        var eventDetailCalled = false
        
        // MARK: Spied methods
        func getEventDetail(success: @escaping (Event) -> (), fail: @escaping (String) -> ()) {
            eventDetailCalled = true
            fail("Fail event detail")
        }
    }
    
    // MARK: - Test login
    
    func testEventDetailSuccess() {
        // Given
        let eventDetailWorkerPresenterSpy = EventDetailPresenterSpy()
        let eventDetailWorkerSpy = EventDetailSuccessWorkerSpy()

        sut = EventDetailInteractorImplementation(eventDetailWorkerPresenterSpy, eventDetailWorkerSpy)
        
        // When
        sut.getEventDetail()
        
        // Then
        let response = eventDetailWorkerPresenterSpy.responseTest
        XCTAssertEqual(response?.event.name, "Event A", "Response event detail name should be Event A")
        XCTAssertEqual(response?.event.description, "Description A", "Response event detail name should be Description A")
        
        XCTAssert(eventDetailWorkerSpy.eventDetailCalled, "Login() should be called")
        XCTAssert(eventDetailWorkerPresenterSpy.presentEventDetailCalled, "Login() should ask presenter to login")
    }
    
    func testEventDetailFail() {
        // Given
        let eventDetailWorkerPresenterSpy = EventDetailPresenterSpy()
        let eventDetailWorkerSpy = EventDetailFaillWorkerSpy()

        sut = EventDetailInteractorImplementation(eventDetailWorkerPresenterSpy, eventDetailWorkerSpy)
        
        // When
        sut.getEventDetail()
        
        
        // Then
        XCTAssert(eventDetailWorkerPresenterSpy.presentEventDetailCalled, "EventDetail present should be called")
        XCTAssertEqual(eventDetailWorkerPresenterSpy.errorMessageTest, "Fail event detail", "event detail message error should be 'Fail event detail'")
        XCTAssertNil(eventDetailWorkerPresenterSpy.responseTest, "Response should be nil in event detail fail")
    }
}
