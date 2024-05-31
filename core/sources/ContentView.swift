//
//  ContentView.swift
//  omnial
//
//  Created by Binder Sophie on 07.03.24.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: ReservationViewModel
    @ObservedObject var viewModelRoom : RoomViewModel

    var body: some View {
        TabView{
            CalendarView(viewModel: viewModel, viewModelRoom: viewModelRoom)
                .tabItem{
                    Label("Calender", systemImage: "calendar")
                }
            ProfileView(viewModel: viewModel, viewModelRoom: viewModelRoom)
                .tabItem{
                    Label("Profile", systemImage: "person")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var model = ReservationModel()
        static var viewModel = ReservationViewModel(model: model)
    
    static var modelRoom = RoomModel()
    static var viewModelRoom = RoomViewModel(model: modelRoom)

    static var previews: some View {
        ContentView(viewModel: viewModel, viewModelRoom: viewModelRoom)
    }
}
