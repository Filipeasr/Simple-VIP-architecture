//
//  EventListPresenterTest.swift
//  VIPTests
//
//  Created by Filipe Rosa.
//

@testable import VIP
import XCTest

class EventListPresenterTest: XCTestCase {
    
    // MARK: - Subject under test
    
    var sut: EventListPresenterImplementation!
    
    // MARK: - Test lifecycle
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: - Test doubles
    
    class ViewControllerSpy: EventListPresenterOutput {
        
        // MARK: Method call expectations
        
        var displayEventListCalled = false
        
        // MARK: Argument expectations
        
        var viewModel: EventListModel.ViewModel?
        var errorMessage: String?
        
        // MARK: Spied methods
        
        func presenter(didSuccessGetEventList viewModel: EventListModel.ViewModel) {
            displayEventListCalled = true
            self.viewModel = viewModel
        }
        
        func presenter(didFailGetEventList message: String) {
            displayEventListCalled = true
            self.errorMessage = message
        }
    }
    
    // MARK: - Test Event List
    
    func testPresentEventListWithSuccess() {
        //Given
        let viewControllerSpy = ViewControllerSpy()
        sut = EventListPresenterImplementation(viewControllerSpy)
        
        //When
        let response = EventListModel.Response(events: Seeds.Events.all)
        sut.interactor(didSuccessGetEventDetail: response)
        
        //Then
        let displayedEvents = viewControllerSpy.viewModel?.displayedEvents
        XCTAssertEqual(displayedEvents?[0].name, "Event A", "Presenting fetched events should properly format event A name")
        XCTAssertEqual(displayedEvents?[1].name, "Event B", "Presenting fetched events should properly format event B name")
    }
    
    func testPresentEventListWithFail() {
        //Given
        let viewControllerSpy = ViewControllerSpy()
        sut = EventListPresenterImplementation(viewControllerSpy)
        
        //When
        sut.interactor(didFailGetEventDetail: "Fail present Event list")
        
        //Then
        let displayedEvents = viewControllerSpy.viewModel?.displayedEvents
        let errorMessageEventList = viewControllerSpy.errorMessage
        XCTAssertEqual(errorMessageEventList, "Fail present Event list", "Event list error message should be 'Fail present Event list'")
        XCTAssertNil(displayedEvents, "displayedEvents should be nil when event list fail")
    }
    
    func testPresentFetchedEventsShouldAskViewControllerToDisplayFetchedEvents() {
        // Given
        let viewControllerSpy = ViewControllerSpy()
        sut = EventListPresenterImplementation(viewControllerSpy)
        
        // When
        let events = Seeds.Events.all
        let response = EventListModel.Response(events: events)
        sut.interactor(didSuccessGetEventDetail: response)
        
        // Then
        XCTAssert(viewControllerSpy.displayEventListCalled, "Presenting fetched events should ask view controller to display them")
    }}
