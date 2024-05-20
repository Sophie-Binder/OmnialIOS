//
//  Person.swift
//  Ominal
//
//  Created by Sophie Binder on 20.05.24.
//

import Foundation

struct PersonModel {
    
    struct Person: Identifiable, Codable, Hashable {
        var id: Int = 0
        var email: String = ""
        var firstname: String = ""
        var surname: String = ""
        var grade: String = ""
        var person_uuid: String = ""
    }
    
    private (set) var person = Person()
    
    private (set) var persons = [Person()]
    
    
    mutating func setPersons(_ loadedPersons: [PersonModel.Person]){
        
        persons = loadedPersons
    }

}
