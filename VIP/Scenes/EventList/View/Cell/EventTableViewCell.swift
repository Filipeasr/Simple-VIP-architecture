//
//  EventTableViewCell.swift
//  VIP
//
//  Created by Filipe Rosa
//

import UIKit

class EventTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    
    func setup(event: EventListModel.ViewModel.DisplayedEvent) {
        nameLabel.text = event.name
    }
}
