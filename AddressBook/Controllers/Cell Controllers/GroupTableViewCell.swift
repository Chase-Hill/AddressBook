//
//  GroupTableViewCell.swift
//  AddressBook
//
//  Created by Chase on 2/13/23.
//

import UIKit

class GroupTableViewCell: UITableViewCell {
    
    // MARK: - Outlets

    @IBOutlet weak var groupNameLabel: UILabel!
    
    @IBOutlet weak var numberOfPeopleLabel: UILabel!
    
    // MARK: - Methods
    func updateView(group: Group) {
        groupNameLabel.text = group.name
        numberOfPeopleLabel.text = "\(group.people) contact(s)"
    }
}
