//
//  Room.swift
//  Ominal
//
//  Created by Sophie Binder on 20.05.24.
//

import Foundation

struct RoomModel {
    
    struct Room: Identifiable, Codable, Hashable {
        var id: Int = 0
        var name: String = ""
        var description: String = ""
    }
    
    private (set) var room = Room()
    
    private (set) var rooms = [Room()]
    
    
    mutating func setRooms(_ loadedRooms: [RoomModel.Room]){
        
        rooms = loadedRooms
    }

}
