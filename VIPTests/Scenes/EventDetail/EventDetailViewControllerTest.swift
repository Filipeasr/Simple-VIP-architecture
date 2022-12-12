//
//  EventDetailViewControllerTest.swift
//  VIPTests
//
//  Created by Filipe Rosa.
//

@testable import VIP
import XCTest

class EventDetailViewControllerTest: XCTestCase {
    
    // MARK: - Subject under test
    
    var sut: EventDetailViewController!
    
    // MARK: - Test lifecycle
    
    override func setUp() {
        super.setUp()
        
        sut = EventDetailViewController.loadFromNib()
        sut.viewDidLoad()
        UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.addSubview(sut!.view)
    }
    
    override func tearDown() {
        super.tearDown()
        
    }

    // MARK: - Test Mock
    
    class EventDetailInteractorSpy: EventDetailInteractor {
        // MARK: Method call expectations
        
        var getEventDetailCalled = false
        
        // MARK: Spied methods
        
        func getEventDetail() {
            getEventDetailCalled = true
        }
    }
    
    // MARK: - Tests
    
    func testShouldGetEventDetailWhenViewDidLoad() {
        // Given
        let eventDetailInteractorSpy = EventDetailInteractorSpy()
        sut.interactor = eventDetailInteractorSpy
        
        // When
        sut.viewDidLoad()
        
        // Then
        XCTAssert(eventDetailInteractorSpy.getEventDetailCalled, "Should fetch event detail right after the viewDidLoad")
    }
    
    func testShouldDisplayFetchedEvent() {
        // Given
        let eventDetailInteractorSpy = EventDetailInteractorSpy()
        sut.interactor = eventDetailInteractorSpy
        
        // When
        let eventDetail = Seeds.EventDetail.eventB
        let viewModel = EventDetailModel.ViewModel(name: eventDetail.name,
                                                   description: eventDetail.description,
                                                   startDate: eventDetail.startDate.getFormattedDate(format: "yyyy-MM-dd"),
                                                   endDate: eventDetail.endDate.getFormattedDate(format: "yyyy-MM-dd"))
        
        sut.presenter(didSuccessGetEventDetail: viewModel)
        
        // Then
        XCTAssertEqual(sut.nameLabel.text, "Event B", "Displayed event detail name should be Event B")
        XCTAssertEqual(sut.descriptionLabel.text, "Description B", "Displayed event detail description should be Description B")
        XCTAssertEqual(sut.startDateLabel.text, "2020-06-02", "Displayed event detail start date should be 2020-06-02")
        XCTAssertEqual(sut.endDateLabel.text, "2020-06-05", "Displayed event detail end date should be 2020-06-05")
    }
    
}

