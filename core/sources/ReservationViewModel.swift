//
//  ReservationViewModel.swift
//  omnial
//
//  Created by Binder Sophie on 04.04.24.
//

import Foundation

class ReservationViewModel: ObservableObject {
    @Published private(set) var reservationModel = ReservationModel()
    
    var reservations: [ReservationModel.Reservation]{
        reservationModel.reservations
    }
    
    func reservationLoaded(_ reservations: ReservationModel.ReservationArray){
        reservationModel.setRecipes(reservations)
    }
    
    
    
}
