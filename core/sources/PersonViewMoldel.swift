//
//  PersonViewMoldel.swift
//  Ominal
//
//  Created by Sophie Binder on 20.05.24.
//

import Foundation

class PersonViewModel: ObservableObject {
    @Published private(set) var personModel : PersonModel
    
    init(model: PersonModel){
        self.personModel = model
    }
    
    var persons: [PersonModel.Person]{
        personModel.persons
    }
    
    func personsLoaded(_ persons: [PersonModel.Person]){
    
        personModel.setPersons(persons)
    }
    
}


