//
//  EventDetailViewController.swift
//  VIP
//
//  Created by Filipe Rosa
//

import UIKit

protocol EventDetailPresenterOutput: AnyObject {
    func presenter(didSuccessGetEventDetail viewModel: EventDetailModel.ViewModel)
    func presenter(didFailGetEventDetail message: String)
}

class EventDetailViewController: UIViewController {

    // MARK: - IBOutlet
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var startDateLabel: UILabel!
    @IBOutlet weak var endDateLabel: UILabel!
    
    // MARK: - Public Properties
    
    var interactor: EventDetailInteractor?
    var router: EventDetailRouter?
    
    // MARK: - Override
    
    override func viewDidLoad() {
        super.viewDidLoad()

        interactor?.getEventDetail()
    }
}

// MARK: - EventDetailPresenterOutput

extension EventDetailViewController: EventDetailPresenterOutput {
    func presenter(didSuccessGetEventDetail viewModel: EventDetailModel.ViewModel) {
        nameLabel.text = viewModel.name
        descriptionLabel.text = viewModel.description
        startDateLabel.text = viewModel.startDate
        endDateLabel.text = viewModel.endDate
    }
    
    func presenter(didFailGetEventDetail message: String) {
        
    }

}
