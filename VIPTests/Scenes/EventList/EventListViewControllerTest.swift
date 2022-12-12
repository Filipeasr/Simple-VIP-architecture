//
//  EventListViewControllerTest.swift
//  VIPTests
//
//  Created by Filipe Rosa.
//

@testable import VIP
import XCTest

class EventListViewControllerTest: XCTestCase {
    
    // MARK: - Subject under test
    
    var sut: EventListViewController!
    var eventListInteractorSpy: EventListInteractorSpy!
    
    // MARK: - Test lifecycle
    
    override func setUp() {
        super.setUp()
        
        sut = EventListViewController.loadFromNib()
        sut.viewDidLoad()
        UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.addSubview(sut!.view)
    }
    
    override func tearDown() {
        super.tearDown()

    }
    
    // MARK: - Test Mock
    
    class EventListInteractorSpy: EventListInteractor {
        
        // MARK: Method call expectations
        
        var getEventListCalled = false
        
        // MARK: Spied methods
        
        func getEventList(_ resquest: EventListModel.Request) {
            getEventListCalled = true
        }
    }
    
    class TableViewSpy: UITableView {
        // MARK: Method call expectations
        
        var reloadDataCalled = false
        
        // MARK: Spied methods
        
        override func reloadData() {
            reloadDataCalled = true
        }
    }
    
    // MARK: - Test Event List
    
    func testShouldGetEventsWhenViewDidLoad() {
        // Given
        let eventListInteractorSpy = EventListInteractorSpy()
        sut.interactor = eventListInteractorSpy
        
        // When
        sut.viewDidLoad()
        
        // Then
        XCTAssert(eventListInteractorSpy.getEventListCalled, "Should fetch events right after the viewDidLoad")
    }
    
    func testShouldDisplayFetchedEvents() {
        // Given
        let tableViewSpy = TableViewSpy()
        sut.eventsTableView = tableViewSpy
        
        // When
        let displayedEvents = [EventListModel.ViewModel.DisplayedEvent(name: "Event A"), EventListModel.ViewModel.DisplayedEvent(name: "Event B")]
        let viewModel = EventListModel.ViewModel(displayedEvents: displayedEvents)
        
        sut.presenter(didSuccessGetEventList: viewModel)
        
        // Then
        XCTAssert(tableViewSpy.reloadDataCalled, "Displaying fetched events should reload the table view")
    }
    
    func testNumberOfSectionsInTableViewShouldAlwaysBeOne() {
        // Given
        sut.eventsTableView?.reloadData()
        
        // When
        let numberOfSections = sut.numberOfSections(in: sut.eventsTableView!)
        
        // Then
        XCTAssertEqual(numberOfSections, 1, "The number of table view sections should always be 1")
    }
    
    func testNumberOfRowsInSectionShouldEqaulNumberOfEventsToDisplay() {
        // Given
        let testDisplayedEvents = [EventListModel.ViewModel.DisplayedEvent(name: "Event A"), EventListModel.ViewModel.DisplayedEvent(name: "Event B")]
        sut.displayedEvents = testDisplayedEvents
        
        // When
        let numberOfRows = sut.tableView(sut.eventsTableView!, numberOfRowsInSection: 0)
        
        // Then
        XCTAssertEqual(numberOfRows, testDisplayedEvents.count, "The number of table view rows should equal the number of events to display")
    }
    
    func testShouldConfigureTableViewCellToDisplayEvent() {
        // Given
        let testDisplayedEvents = [EventListModel.ViewModel.DisplayedEvent(name: "Event A"), EventListModel.ViewModel.DisplayedEvent(name: "Event B")]
        sut.displayedEvents = testDisplayedEvents
        
         //When
        let indexPath = IndexPath(row: 0, section: 0)
        let cell = sut.tableView(sut.eventsTableView!, cellForRowAt: indexPath) as? EventTableViewCell

        // Then
        XCTAssertEqual(cell?.nameLabel?.text, "Event A", "A properly configured table view cell should display the event name")
    }
}
