//
//  ReservationViewModel.swift
//  omnial
//
//  Created by Binder Sophie on 04.04.24.
//

import Foundation

class ReservationViewModel: ObservableObject {
    @Published private(set) var reservationModel : ReservationModel
    
    init(model: ReservationModel){
        self.reservationModel = model
    }
    
    var reservations: [ReservationModel.Reservation]{
        reservationModel.reservations
    }
    
    var allReservations: [ReservationModel.Reservation]{
        reservationModel.allReservations
    }
    
    func reservationLoaded(_ reservations: [ReservationModel.Reservation]){
    
        reservationModel.setReservations(reservations)
    }
    
    func AllReservationLoaded(_ reservations: [ReservationModel.Reservation]){
    
        reservationModel.setAllReservations(reservations)
    }
    
    
    func getReservationByDateTime(date: String, time1: String, time2: String) -> ReservationModel.Reservation {
        var res: ReservationModel.Reservation = ReservationModel.Reservation()
        reservations.forEach { reservation in
            if reservation.reservationDate == date && reservation.startTime == time1 && reservation.endTime == time2 {
                res =  reservation
            }
        }
        return res
    }
    
    
    
}
