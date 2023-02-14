//
//  GrouplListTableViewController.swift
//  AddressBook
//
//  Created by Chase on 2/13/23.
//

import UIKit

class GrouplListTableViewController: UITableViewController {

    // MARK: - LifeCycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Action
    
    @IBAction func addGroupButtonPressed(_ sender: Any) {
        GroupController.sharedInstance.createGroup()
        tableView.reloadData()
    }
   
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return GroupController.sharedInstance.groups.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Cell Identifier
        let cell = tableView.dequeueReusableCell(withIdentifier: "groupCell", for: indexPath)
        let groupDisplayed = GroupController.sharedInstance.groups[indexPath.row]
        var cellConfig = cell.defaultContentConfiguration()
        cellConfig.text = groupDisplayed.name
        cellConfig.secondaryText = "\(groupDisplayed.people.count)"
        cell.contentConfiguration = cellConfig
        
        return cell
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let groupToBeDeleted = GroupController.sharedInstance.groups[indexPath.row]
            GroupController.sharedInstance.deleteGroup(groupToDelete: groupToBeDeleted)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toPerson" {
            if let indexPath = tableView.indexPathForSelectedRow,
               let destinationVC = segue.destination as? PersonListTableViewController {
                let groupToSend = GroupController.sharedInstance.groups[indexPath.row]
                destinationVC.groupReciever = groupToSend
            }
        }
    }
}
