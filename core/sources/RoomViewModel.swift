//
//  RoomViewModel.swift
//  Ominal
//
//  Created by Sophie Binder on 20.05.24.
//

import Foundation


class RoomViewModel: ObservableObject {
    @Published private(set) var roomModel : RoomModel
    
    init(model: RoomModel){
        self.roomModel = model
    }
    
    var rooms: [RoomModel.Room]{
        roomModel.rooms
    }
    
    func roomsLoaded(_ rooms: [RoomModel.Room]){
    
        roomModel.setRooms(rooms)
    }
    
    func getRoomNames() -> [String]{
        var names: [String] = []
        rooms.forEach{ room in
            names.append(room.name)
        }
        
        return names
    }
    
   func getNameById(id: Int) -> RoomModel.Room {
       var room1: RoomModel.Room = RoomModel.Room()
        rooms.forEach{ room in
            if room.id == id {
               room1 = room
            }
        }
        return room1
    }
    
    func getIdByName(name: String) -> Int {
        var id: Int = 0
        rooms.forEach{ room in
            if room.name == name {
                id = room.id
            }
        }
        return id
    }

}
