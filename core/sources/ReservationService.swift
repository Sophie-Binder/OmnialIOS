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

func AllLoadAllReservations() async -> [ReservationModel.Reservation] {

    let reservationUrlString = "http://localhost:8080/api/reservations/list"
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
    print("---")
    print(reservation)
    print("---")
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


func updateReservation(id: Int ,reservation: ReservationModel.Reservation) {
    print("---")
    print(reservation)
    print("---")
    let reservationUrlString = "http://localhost:8080/api/reservations/"+"\(id)"
    print(reservationUrlString)
    let url = URL(string: reservationUrlString)!
    var request = URLRequest(url: url)
    request.httpMethod = "PUT"
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

func deleteReservation(id: Int) {
    let reservationUrlString = "http://localhost:8080/api/reservations/"+"\(id)"
    print(reservationUrlString)
    let url = URL(string: reservationUrlString)!
    var request = URLRequest(url: url)
    request.httpMethod = "DELETE"
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
