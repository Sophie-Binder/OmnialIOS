//
//  ContentView.swift
//  omnial
//
//  Created by Binder Sophie on 07.03.24.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: ReservationViewModel
    var body: some View {
        TabView{
            CalendarView(viewModel: viewModel)
                .tabItem{
                    Label("Calender", systemImage: "calendar")
                }
            ProfileView()
                .tabItem{
                    Label("Profile", systemImage: "person")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var model = ReservationModel()
        static var viewModel = ReservationViewModel(model: model)
    static var previews: some View {
        ContentView(viewModel: viewModel)
    }
}
