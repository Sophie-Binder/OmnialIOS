//
//  ContentView.swift
//  omnial
//
//  Created by Binder Sophie on 07.03.24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView{
            CalendarView()
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
    static var previews: some View {
        ContentView()
    }
}
