//
//  Reservation.swift
//  omnial
//
//  Created by Binder Sophie on 14.03.24.
//

import Foundation

struct ReservationModel {
    
    struct Reservation: Identifiable, Codable, Hashable {
        var id: Int = 0
        var roomId: Int = 0
        var personId: Int = 0
        var time1: String = ""
        var time2: String = ""
        var date: String = ""
    }
    
    private (set) var reservation = Reservation()
    
    private (set) var reservations = [Reservation()]
    
    struct ReservationArray: Decodable {
        var reservations: [Reservation] = []
    }
    
    mutating func setRecipes(_ loadedReservations: ReservationArray){
        reservations = loadedReservations.reservations
    }

}
/*
struct Reservation: Identifiable, Codable, Hashable {
    var id: Int = 0
    var roomId: Int = 0
    var personId: Int = 0
    var time1: String = ""
    var time2: String = ""
    var date: String = ""
}*/
