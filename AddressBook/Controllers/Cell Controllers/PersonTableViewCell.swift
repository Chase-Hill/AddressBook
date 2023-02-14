//
//  PeopleTableViewCell.swift
//  AddressBook
//
//  Created by Chase on 2/14/23.
//

import UIKit

protocol PersonTableViewCellDelegate: AnyObject {
    func toggleFavoriteButtonTapped(cell: PersonTableViewCell)
}

class PersonTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet weak var personNameLabel: UILabel!
    
    @IBOutlet weak var favoriteButton: UIButton!
    
    // MARK: - Properties
    
    weak var delegate: PersonTableViewCellDelegate?
    
    var person: Person? {
        didSet {
            updateViews()
        }
    }
    
    // MARK: - Helper
    
    func updateViews() {
        guard let person = person else {return}
        personNameLabel.text = person.name
        
        let favoriteImageName = person.isFavorite ? "star.fill" : "star"
        let favoriteImage = UIImage(systemName: favoriteImageName)
        favoriteButton.setImage(favoriteImage, for: .normal)
    }
    
    
    
    // MARK: - Action
    
    @IBAction func favoriteButtonTapped(_ sender: Any) {
        delegate?.toggleFavoriteButtonTapped(cell: self)
    }
}
