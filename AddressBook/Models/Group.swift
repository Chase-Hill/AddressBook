//
//  Group.swift
//  AddressBook
//
//  Created by Trevor Adcock on 10/12/21.
//

import Foundation

class Group: Codable {
    let id: UUID
    var name: String
    var people: [Person]
    
    init(id: UUID = UUID(), name: String, people: [Person] = []) {
        self.id = id
        self.name = name
        self.people = people
    }
}

extension Group: Equatable {
    static func == (lhs: Group, rhs: Group) -> Bool {
        return lhs.id == rhs.id
    }
}
