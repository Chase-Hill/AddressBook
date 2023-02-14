//
//  ContactViewController.swift
//  AddressBook
//
//  Created by Chase on 2/13/23.
//

import UIKit

class ContactViewController: UIViewController {

    var personObjectReciever: Person?
    
    // MARK: - Outlets
    
    @IBOutlet weak var contactNameTextField: UITextField!
    
    @IBOutlet weak var contactAddressTextField: UITextField!
    
    @IBOutlet weak var favoriteButton: UIBarButtonItem!
    
    // MARK: - LifeCycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateViews()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    func updateViews() {
        guard let person = personObjectReciever else {return}
        contactNameTextField.text = person.name
        contactAddressTextField.text = person.address
        
        updateFavoriteButton()
    }
    
    // MARK: - Helper
    
    func updateFavoriteButton() {
        guard let person = personObjectReciever else {return}
        let favoriteImageName = person.isFavorite ? "star.fill" : "star"
        let favoriteImage = UIImage(systemName: favoriteImageName)
        favoriteButton.image = favoriteImage
    }
    
    // MARK: - Actions
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let person = personObjectReciever,
              let name = contactNameTextField.text,
              let address = contactAddressTextField.text else {return}
        PersonController.updatePerson(personToUpdate: person, newName: name, newAddress: address)
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func favoriteButtonTapped(_ sender: Any) {
        guard let person = personObjectReciever else {return}
        PersonController.toggleFavorite(person: person)
        updateFavoriteButton()
    }
    
}
