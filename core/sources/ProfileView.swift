//
//  ProfileView.swift
//  omnial
//
//  Created by Binder Sophie on 07.03.24.
//

import Foundation
import SwiftUI

struct ProfileView: View {
    @ObservedObject var viewModel : ReservationViewModel
    @ObservedObject var viewModelRoom : RoomViewModel
    @State var message: String = ""
    @State var isActive: Bool = false
    @State var isActive2: Bool = false
    @State var isActive3: Bool = false
    
    @State var currRes: ReservationModel.Reservation = ReservationModel.Reservation()
    
    @State  var currdate: Date = Date.now
    @State  var currentDate1: Date = Date.now
    @State  var currentDate2: Date = Date.now
    
    @State private var selection = "Fotostudio"
    
    let dateFormatter1 = DateFormatter()
    let dateFormatter2 = DateFormatter()
    
    
    var body: some View{
       
        ZStack(alignment: .bottomTrailing) {
            VStack(alignment: .center, spacing: 20) {
                
                HStack{
                    Text("Sophie Binder")
                        .font(.title)
                        .foregroundStyle(.black)
                
                    
                }
                .frame(width: 250, height: 100, alignment: .top)
                .padding()
                .background(.white)
                .cornerRadius(15)
                
                
                Text("Deine Reservierungen")
                    .font(.largeTitle)
                    .foregroundStyle(.white)
                
                ScrollView{

                    VStack(alignment: .leading, spacing: 10){
                        
                        
                        
                        ForEach(viewModel.reservations) {reservation in
                            ReservationView(reservation: reservation)
                        }
                        
                        
                        
                        
                        
                        HStack{
                            Button {
                                isActive3 = true
                                          } label: {
                                              Image(systemName: "plus")
                                                  .font(.title.weight(.semibold))
                                                  .padding()
                                                  .background(Color(red: 245/255, green: 185/255, blue: 99/255, opacity: 2))
                                                  .foregroundColor(.white)
                                                  .clipShape(Circle())
                                                  .shadow(radius: 4, x: 0, y: 4)

                                          }
                        }
                        .frame(width: 100, alignment: .center)
                        .padding()
                        .background(.white)
                        .cornerRadius(15)
                        
                        
                        
                    }
                }
                  
            }
            .frame(maxWidth: .infinity)
            .frame(maxHeight: .infinity)
            .background( Color(red: 30/255, green: 68/255, blue: 77/255, opacity: 1).edgesIgnoringSafeArea(.all))
            
            
            if isActive3 {
                
                CustomDialogEdit(isActive: $isActive3, title: "Reservation", message: "", buttonTitle: "Speicher", action: {
                    
                dateFormatter1.dateFormat = "'T'HH:mm:ss"
                dateFormatter2.dateFormat = "yyyy-MM-dd"
                    
                    addReservation(reservation: ReservationModel.Reservation(roomId: 1, personId: 1, startTime: dateFormatter2.string(from: currdate)+dateFormatter1.string(from: currentDate1), endTime: dateFormatter2.string(from: currdate)+dateFormatter1.string(from: currentDate2), reservationDate: dateFormatter2.string(from: currdate)))
                    
                    currdate = Date.now
                    currentDate1 = Date.now
                    currentDate2 = Date.now
                    
                    


                    Task {
                         do {
                             try await Task.sleep(nanoseconds: 1_000_000_000)
                             let reservations = try await loadAllReservations(weekDay: "2024-03-01");
                             viewModel.reservationLoaded(reservations)
                             print("DFFGDERFG")
                         }
                         catch {
                             print(error)
                         }
                     }
                    //let reservations = try? await loadAllReservations(weekDay: "2024-03-01");
                    
                }, currReservation: nil, currdate: $currdate, currentDate1: $currentDate1, currentDate2: $currentDate2)
            }
            
        }
    }
    
}

struct ReservationView: View{
    
    var reservation: ReservationModel.Reservation
    
    var body: some View{
        VStack{
            Text("\(reservation.reservationDate)")
            Text("\(reservation.startTime)")
            Text("\(reservation.endTime)")
        }
        .frame(width: 100, alignment: .center)
        .padding()
        .background(.white)
        .cornerRadius(15)
        
    }
}




struct ProfileView_Previews: PreviewProvider {
    static var model = ReservationModel()
    static var viewModel = ReservationViewModel(model: model)

    static var modelRoom = RoomModel()
    static var viewModelRoom = RoomViewModel(model: modelRoom)

    static var previews: some View {
    ProfileView(viewModel: viewModel, viewModelRoom: viewModelRoom)
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
