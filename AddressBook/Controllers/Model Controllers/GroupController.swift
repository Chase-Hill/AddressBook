//
//  GroupController.swift
//  AddressBook
//
//  Created by Chase on 2/13/23.
//

import Foundation

class GroupController {
    
    // MARK: - Properties
    
    static let sharedInstance = GroupController()
    
    ///Source of Truth

    var groups: [Group] = []
    
    // MARK: - Initializers
    
    init() {
        loadContactsFromDisk()
    }
    
    func createGroup(name: String = "Untitled Group", people: [Person] = []) {
        let group = Group(name: name, people: people)
        groups.append(group)
    
        saveContactsToDisk()
    }
    
    func updateGroup(groupToUpdate: Group, groupNameToUpdate: String) {
        groupToUpdate.name = groupNameToUpdate
        
        saveContactsToDisk()
    }
    
    func deleteGroup(groupToDelete: Group) {
        guard let index = groups.firstIndex(of: groupToDelete) else {return}
        groups.remove(at: index)
        
        saveContactsToDisk()
    }
    
    private var fileURL: URL? {
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {return nil}
        let finalURL = documentsDirectory.appendingPathComponent("people.json")
        return finalURL
    }
    
    func saveContactsToDisk() {
        // 1: Get the address to save the file to
        guard let saveLocation = fileURL else {return}
        // 2: Convert the Swift struct or class inot JSON Data
        do {
            let jsonData = try JSONEncoder().encode(groups)
            // 3: save (write) the data to the address from step 1
            try jsonData.write(to: saveLocation)
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func loadContactsFromDisk() {
        // 1. Get the address the data is saved at
        guard let url = fileURL else {return}
        // 2. Load that JSON data from the address
        do {
            let retrievedJSONData = try Data(contentsOf: url)
            // 3. Convert from JSON to our Swift Model Object Type
            let decodedGroups = try JSONDecoder().decode([Group].self, from: retrievedJSONData)
            self.groups = decodedGroups
        } catch let error {
            print(error.localizedDescription)
        }
    }
}
