//
//  RoomService.swift
//  Ominal
//
//  Created by Sophie Binder on 20.05.24.
//

import Foundation


func loadAllRooms() async -> [RoomModel.Room] {

    let roomUrlString = "http://localhost:8080/api/rooms/list"
    let url = URL(string: roomUrlString)!
    var rooms = [RoomModel.Room]()
    if let (data, _) = try? await URLSession.shared.data(from: url) {
        if let loadedRooms = try? JSONDecoder().decode([RoomModel.Room].self, from: data) {
            rooms = loadedRooms
        } else {
            print("failed3")
            print(url)
        }
    } else {
        print("failed1")
    }
    
    return rooms;
}

