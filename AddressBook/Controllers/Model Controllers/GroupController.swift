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
    
    func createGroup() {
        
    }
    
    func updateGroup() {
        
    }
    
    func deleteGroup() {
        
    }
    
    private var fileURL: URL? {
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {return nil}
        let finalURL = documentsDirectory.appendingPathComponent("people.json")
        return finalURL
    }
    
    func save() {
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
    
    func load() {
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
