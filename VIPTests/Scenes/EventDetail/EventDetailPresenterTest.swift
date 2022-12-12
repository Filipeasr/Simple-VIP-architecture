//
//  EventDetailPresenterTest.swift
//  VIPTests
//
//  Created by Filipe Rosa.
//

@testable import VIP
import XCTest

class EventDetailPresenterTest: XCTestCase {
    
    // MARK: - Subject under test
    
    var sut: EventDetailPresenterImplementation!
    
    // MARK: - Test lifecycle
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: - Test Mock
    
    class ViewControllerSpy: EventDetailPresenterOutput {
        
        // MARK: Method call expectations
        
        var displaySuccessEventDetailCalled = false
        var displayFailEventDetailCalled = false

        // MARK: Argument expectations
        
        var viewModel: EventDetailModel.ViewModel?
        var errorMessage: String?
        
        // MARK: EventDetailPresenterOutput

        func presenter(didSuccessGetEventDetail viewModel: EventDetailModel.ViewModel) {
            displaySuccessEventDetailCalled = true
            self.viewModel = viewModel
        }
        
        func presenter(didFailGetEventDetail message: String) {
            displayFailEventDetailCalled = true
            self.errorMessage = message
        }
    }
    
    // MARK: - Tests

    func testPresentSuccessEventDetail() {
        //Given
        let viewControllerSpy = ViewControllerSpy()
        sut = EventDetailPresenterImplementation(viewControllerSpy)
        let event = Seeds.EventDetail.eventA
        
        //When
        let response = EventDetailModel.Response(event: event)
        sut.interactor(didSuccessGetEventDetail: response)
        
        //Then
        let eventDetailViewModel = viewControllerSpy.viewModel
        XCTAssertEqual(eventDetailViewModel?.name, "Event A", "Event detail name should be Event A")
        XCTAssertEqual(eventDetailViewModel?.description, "Description A", "Event detail description should be Description A")
        XCTAssertEqual(eventDetailViewModel?.startDate, "15/12/10", "Event detail start date should be 15/12/10")
        XCTAssertEqual(eventDetailViewModel?.endDate, "52/11/27", "Event detail end date should be 52/11/27")
    }
    
    func testPresentFailEventDetail() {
        //Given
        let viewControllerSpy = ViewControllerSpy()
        sut = EventDetailPresenterImplementation(viewControllerSpy)

        //When
        sut.interactor(didFailGetEventDetail: "Fail present Event detail")
        
        //Then
        let errorMessageEventDetail = viewControllerSpy.errorMessage
        XCTAssertEqual(errorMessageEventDetail, "Fail present Event detail", "Event detail error message should be 'Fail present Event detail'")
    }

    func testPresentEventDetailShouldAskViewControllerToDisplayEvent() {
      // Given
        let viewControllerSpy = ViewControllerSpy()
        sut = EventDetailPresenterImplementation(viewControllerSpy)
        let event = Seeds.EventDetail.eventB
        
      // When
        let response = EventDetailModel.Response(event: event)
        sut.interactor(didSuccessGetEventDetail: response)
      
      // Then
      XCTAssert(viewControllerSpy.displaySuccessEventDetailCalled, "Presenting events should ask view controller to display it")
    }
    
}
