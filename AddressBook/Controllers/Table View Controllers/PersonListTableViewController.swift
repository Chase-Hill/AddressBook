//
//  PersonListTableViewController.swift
//  AddressBook
//
//  Created by Chase on 2/13/23.
//

import UIKit

class PersonListTableViewController: UITableViewController {

    var groupReciever: Group?

    private var filteredPeople: [Person] {
        if switchButton.isOn {
            return groupReciever?.people.filter { $0.isFavorite } ?? []
        } else {
            return groupReciever?.people ?? []
        }
    }
    
    // MARK: - Outlet
    
    @IBOutlet weak var groupNameTextField: UITextField!
    
    @IBOutlet weak var switchButton: UISwitch!
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        guard let groupName = groupReciever else {return}
        GroupController.sharedInstance.updateGroup(groupToUpdate: groupName, groupNameToUpdate: groupNameTextField.text ?? "Untitled")
    }
    
    // MARK: - Actions
    
    @IBAction func addButtonTapped(_ sender: Any) {
        guard let group = groupReciever else {return}
        PersonController.createPerson(group: group)
        tableView.reloadData()
    }
    
    @IBAction func toggleSwitch(_ sender: Any) {
        tableView.reloadData()
    }
    
    func updateViews() {
        guard let groupReciever = groupReciever else {return}
        groupNameTextField.text = groupReciever.name
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredPeople.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "personCell", for: indexPath) as? PersonTableViewCell else {return UITableViewCell()}

        let personObject = filteredPeople[indexPath.row]
        cell.person = personObject
        cell.delegate = self
        
        return cell
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let group = groupReciever else {return}
            let person = filteredPeople[indexPath.row]
            PersonController.deletePerson(personToDelete: person, from: group)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toContactDetails" {
            if let indexPath = tableView.indexPathForSelectedRow {
                if let destination = segue.destination as? ContactViewController {
                    let person = filteredPeople[indexPath.row]
                    destination.personObjectReciever = person
                }
            }
        }
    }
}

extension PersonListTableViewController: PersonTableViewCellDelegate {
    func toggleFavoriteButtonTapped(cell: PersonTableViewCell) {
        guard let personIndex = cell.person else {return}
        PersonController.toggleFavorite(person: personIndex)
        cell.updateViews()
    }
}
