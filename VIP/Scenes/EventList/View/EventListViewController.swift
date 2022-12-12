//
//  EventListViewController.swift
//  VIP
//
//  Created by Filipe Rosa
//

import UIKit

protocol EventListPresenterOutput: AnyObject {
    func presenter(didSuccessGetEventList viewModel: EventListModel.ViewModel)
    func presenter(didFailGetEventList message: String)
}

class EventListViewController: UIViewController {

    // MARK: - Public Properties
    
    var interactor: EventListInteractor?
    var router: EventListRouter?
        
    var displayedEvents: [EventListModel.ViewModel.DisplayedEvent] = [] {
        didSet{
            eventsTableView?.reloadData()
        }
    }
    
    var errorMessage: String = ""

    // MARK: - Outlet
    
    @IBOutlet weak var eventsTableView: UITableView?

    // MARK: - Override
    
    override func viewDidLoad() {
        super.viewDidLoad()

        eventsTableView?.delegate = self
        eventsTableView?.dataSource = self

        eventsTableView?.register(UINib(nibName: "EventTableViewCell", bundle: nil), forCellReuseIdentifier: "EventTableViewCell")

        let request = EventListModel.Request()
        interactor?.getEventList(request)

    }
}

// MARK: - EventListPresenterOutput

extension EventListViewController: EventListPresenterOutput {
    func presenter(didSuccessGetEventList viewModel: EventListModel.ViewModel) {
        displayedEvents = viewModel.displayedEvents
    }
    
    func presenter(didFailGetEventList message: String) {
        errorMessage = message
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension EventListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayedEvents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "EventTableViewCell", for: indexPath) as? EventTableViewCell else { return UITableViewCell() }
        
        let displayedEvent = displayedEvents[indexPath.row]
        cell.setup(event: displayedEvent)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let displayedEvent = displayedEvents[indexPath.row]
        router?.routeToEventDetail(displayedEvent.name)
    }
}
