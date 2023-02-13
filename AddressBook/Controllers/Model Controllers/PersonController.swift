//
//  File.swift
//  AddressBook
//
//  Created by Chase on 2/13/23.
//

import Foundation

class PersonController {
    
    static func createPerson(name: String = "New Contact", address: String = "", group: Group) {
        let newPerson = Person(name: name, address: address)
        group.people.append(newPerson)
        
        GroupController.sharedInstance.save()
    }
    
    static func updatePerson(personToUpdate: Person, newName: String, newAddress: String) {
        personToUpdate.name = newName
        personToUpdate.address = newAddress
        
        GroupController.sharedInstance.save()
    }
    
    static func deletePerson(personToDelete: Person, from group: Group) {
        guard let index = group.people.firstIndex(of: personToDelete) else {return}
        group.people.remove(at: index)
        
        GroupController.sharedInstance.save()
    }
}
