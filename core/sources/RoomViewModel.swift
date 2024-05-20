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

}
