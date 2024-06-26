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
        var startTime: String = ""
        var endTime: String = ""
        var reservationDate: String = ""
    }
    
    struct ReservationDTO: Identifiable, Codable, Hashable {
        var id: Int = 0
        var roomId: Int = 0
        var personId: Int = 0
        var startTime: Date = Date()
        var endTime: Date = Date()
        var reservationDate: Date = Date()
    }
    
    private (set) var reservation = Reservation()
    
    private (set) var reservations = [Reservation()]
    
    private (set) var allReservations = [Reservation()]
    
    
    mutating func setReservations(_ loadedReservations: [ReservationModel.Reservation]){
        
        reservations = loadedReservations
    }
    
    mutating func setAllReservations(_ loadedReservations: [ReservationModel.Reservation]){
        
        allReservations = loadedReservations
    }


}

/*struct ReservationArray: Decodable {
    var reservations: [Reservation] = []
}*/

/*
struct Reservation: Identifiable, Codable, Hashable {
    var id: Int = 0
    var roomId: Int = 0
    var personId: Int = 0
    var time1: String = ""
    var time2: String = ""
    var date: String = ""
}*/

