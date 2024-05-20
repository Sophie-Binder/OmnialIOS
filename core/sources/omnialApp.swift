//
//  omnialApp.swift
//  omnial
//
//  Created by Binder Sophie on 07.03.24.
//

import SwiftUI
fileprivate let model = ReservationModel()
fileprivate let modelRoom = RoomModel()


@main
struct omnialApp: App {
    var viewModel = ReservationViewModel(model: model)
    var viewModelRoom = RoomViewModel(model: modelRoom)
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: viewModel, viewModelRoom: viewModelRoom)
        }
    }
}
