//
//  ReservationService.swift
//  omnial
//
//  Created by Binder Sophie on 04.04.24.
//

import Foundation


func loadAllReservations(weekDay: String) async -> ReservationModel.ReservationArray {
    let reservationUrlString = "https://localhost:8080/api/reservatioons/week/"+weekDay
    let url = URL(string: reservationUrlString)!
    var reservations = ReservationModel.ReservationArray()
    if let (data, _) = try? await URLSession.shared.data(from: url) {
        
        if let loadedReservations = try? JSONDecoder().decode(ReservationModel.ReservationArray.self, from: data) {
            reservations = loadedReservations
        } else {
            print("failed3")
        }
    } else {
        print("failed1")
    }
    
    return reservations
}
