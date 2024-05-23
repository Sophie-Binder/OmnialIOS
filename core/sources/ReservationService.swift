//
//  ReservationService.swift
//  omnial
//
//  Created by Binder Sophie on 04.04.24.
//

import Foundation


func loadAllReservations(weekDay: String) async -> [ReservationModel.Reservation] {

    let reservationUrlString = "http://localhost:8080/api/reservations/week/"+weekDay
    let url = URL(string: reservationUrlString)!
    var reservations = [ReservationModel.Reservation]()
    if let (data, _) = try? await URLSession.shared.data(from: url) {
        if let loadedReservations = try? JSONDecoder().decode([ReservationModel.Reservation].self, from: data) {
            reservations = loadedReservations
        } else {
            print("failed3")
            print(url)
        }
    } else {
        print("failed1")
    }
    
    return reservations
}

func addReservation(reservation: ReservationModel.Reservation) {
    let reservationUrlString = "http://localhost:8080/api/reservations"
    let url = URL(string: reservationUrlString)!
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    let data = try! JSONEncoder().encode(reservation)
    request.httpBody = data
    request.setValue(
        "application/json",
        forHTTPHeaderField: "Content-Type"
    )
    let task = URLSession.shared.dataTask(with: request) { data, response, error in
        let statusCode = (response as! HTTPURLResponse).statusCode

        if statusCode == 200 ||  statusCode == 204{
            print("SUCCESS")
        } else {
            print("FAILURE")
        }
    }

    task.resume()
}

