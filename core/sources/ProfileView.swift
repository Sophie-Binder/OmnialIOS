//
//  ProfileView.swift
//  omnial
//
//  Created by Binder Sophie on 07.03.24.
//

import Foundation
import SwiftUI

struct ProfileView: View {
    
    @State var isActive: Bool = false
    
    var body: some View{
        
        
        ZStack{
            VStack{
                Button {
                    isActive = true
                } label: {
                    Text("show")
                }
            }
            if isActive {
                CustomDialog(isActive: $isActive, title: "Reservation", message: "Your Reservation is on in ", buttonTitle: "OK", action: {print("Works")})
                    .zIndex(1)
            }
        }
    
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}


/*Text("Profile")
Button("Bordered Prominent Button") {

   }
   .buttonStyle(.borderedProminent)
   .buttonBorderShape(.roundedRectangle(radius: 8))
   .alert("Important message", isPresented: $showingAlert) {
       Button("OK") { }
   }
}*/
