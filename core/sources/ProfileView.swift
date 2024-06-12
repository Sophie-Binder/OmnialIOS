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
                        
                        
                        ForEach(viewModel.allReservations) {reservation in
                            var room: RoomModel.Room = viewModelRoom.getNameById(id: reservation.roomId)
                                
                                VStack{
                                   
                                    Text("\(room.name)")
                                    Text("\(reservation.reservationDate)")
                                    Text("\(String(reservation.startTime.prefix(5))) bis \(String(reservation.endTime.prefix(5)))")
                                    Text("")
                                    Button {
                                        isActive = true
                                        message = "Your Reservation is on \(reservation.reservationDate) from \(reservation.startTime) to \(reservation.endTime)"
                                        currRes = reservation
                                        dateFormatter1.dateFormat = "yyyy-MM-dd"
                                        currdate = dateFormatter1.date(from: reservation.reservationDate)!
                                        dateFormatter1.dateFormat = "yyyy-MM-dd HH:mm:ss"
                                        currentDate1 = dateFormatter1.date(from: "\(reservation.reservationDate) \(reservation.startTime)")!
                                        currentDate2 = dateFormatter1.date(from: "\(reservation.reservationDate) \(reservation.endTime)")!
                                        
                                    } label: {
                                        ZStack {
                                            Label("Edit", systemImage: "pencil")
                                                    .padding()
                                                    .foregroundStyle(.black)
                                            
                                            
                                        }
                                    }
                                }
                                .frame(width: 180, alignment: .center)
                                .padding()
                                .background(.white)
                                .cornerRadius(15)
                                
                            
                            //ReservationView(reservation: reservation, room: room)
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
                        .frame(width: 180, alignment: .center)
                        .padding()
                        .background(.white)
                        .cornerRadius(15)
                        
                        
                        
                    }
                }.task{
                    let reservations = await AllLoadAllReservations();
                    viewModel.AllReservationLoaded(reservations)
                
                }
                  
            }
            .frame(maxWidth: .infinity)
            .frame(maxHeight: .infinity)
            .background( Color(red: 30/255, green: 68/255, blue: 77/255, opacity: 1).edgesIgnoringSafeArea(.all))
            
            if isActive {
                CustomDialog(isActive: $isActive, title: "Reservation", message: message, buttonTitle: "Edit", action: {
                       isActive2 = true
                    
                }, buttonTitle2: "Delete", action2: {
                    
                    deleteReservation(id: currRes.id)
                    
                    Task {
                         do {
                             try await Task.sleep(nanoseconds: 1_000_000_000)
                             let reservations = try await AllLoadAllReservations();
                             viewModel.AllReservationLoaded(reservations)
                             
                         }
                         catch {
                             print(error)
                         }
                     }
                    
                    
                })
                    .zIndex(1)
            }
            
            if isActive2 {
                
                CustomDialogEdit(isActive: $isActive2, title: "Reservation", message: "", buttonTitle: "Speicher", action: {
                    
                    dateFormatter1.dateFormat = "'T'HH:mm:ss"
                    dateFormatter2.dateFormat = "yyyy-MM-dd"
                    
                    updateReservation(id:  currRes.id, reservation: ReservationModel.Reservation( id: currRes.id, roomId: viewModelRoom.getIdByName(name: selection), personId: 1, startTime: dateFormatter2.string(from: currdate)+dateFormatter1.string(from: currentDate1), endTime: dateFormatter2.string(from: currdate)+dateFormatter1.string(from: currentDate2), reservationDate: dateFormatter2.string(from: currdate)))
                    
                    Task {
                         do {
                             try await Task.sleep(nanoseconds: 1_000_000_000)
                             let reservations = try await AllLoadAllReservations();
                             viewModel.AllReservationLoaded(reservations)
                           
                         }
                         catch {
                             print(error)
                         }
                     }
                   
                } , currReservation: currRes ,selection: $selection, currdate: $currdate, currentDate1: $currentDate1, currentDate2: $currentDate2)
            }
            
            
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
                             let reservations = try await AllLoadAllReservations();
                             viewModel.AllReservationLoaded(reservations)
                             print("DFFGDERFG")
                         }
                         catch {
                             print(error)
                         }
                     }
                    //let reservations = try? await loadAllReservations(weekDay: "2024-03-01");
                    
                }, currReservation: nil, selection: .constant("Fotostudio"),currdate: $currdate, currentDate1: $currentDate1, currentDate2: $currentDate2)
                
            }
            
        }
    }
    


struct ReservationView: View{
    
    var reservation: ReservationModel.Reservation
    var room: RoomModel.Room
  
    var body: some View{
        
        VStack{
           
            Text("\(room.name)")
            Text("\(reservation.reservationDate)")
            Text("\(String(reservation.startTime.prefix(5))) bis \(String(reservation.endTime.prefix(5)))")
            Text("")
            /*
            Button {
                isActive = true
                message = "Your Reservation is on \(weekDay[number2]) from \(times[number][0]) to \(times[number][1])"
                currRes = viewModel.getReservationByDateTime(date: weekDay[number2], time1: times[number][0], time2: times[number][1])
                dateFormatter1.dateFormat = "yyyy-MM-dd"
                currdate = dateFormatter1.date(from: weekDay[number2])!
                dateFormatter1.dateFormat = "yyyy-MM-dd HH:mm:ss"
                currentDate1 = dateFormatter1.date(from: "\(weekDay[number2]) \(times[number][0])")!
                currentDate2 = dateFormatter1.date(from: "\(weekDay[number2]) \(times[number][1])")!
                
            } label: {
                ZStack {
                    
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color(red: 245/255, green: 185/255, blue: 99/255, opacity: 2))
                        .frame( height: 55, alignment: .leading)
                    
                }
            }*/
        }
        .frame(width: 180, alignment: .center)
        .padding()
        .background(.white)
        .cornerRadius(15)
        
    }
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


