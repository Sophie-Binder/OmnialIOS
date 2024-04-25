//
//  omnialApp.swift
//  omnial
//
//  Created by Binder Sophie on 07.03.24.
//

import SwiftUI
fileprivate let model = ReservationModel()


@main
struct omnialApp: App {
        var viewModel = ReservationViewModel(model: model)
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: viewModel)
        }
    }
}
