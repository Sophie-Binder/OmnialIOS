//
//  CalendarView.swift
//  omnial
//
//  Created by Binder Sophie on 07.03.24.
//

import Foundation
import SwiftUI

struct CalendarView: View {
    
    @ObservedObject var viewModel : ReservationViewModel
    @ObservedObject var viewModelRoom : RoomViewModel
    @State var message: String = ""
    @State var isActive: Bool = false
    @State var isActive2: Bool = false
    @State var isActive3: Bool = false
    
    @State var currRes: ReservationModel.Reservation = ReservationModel.Reservation()
    
    @State  var currdate: Date = Date.now
    @State  var currentDate1: Date = Date()
    @State  var currentDate2: Date = Date()
    
    @State private var selection = "Fotostudio"
  
    
    
    let reservations: [ReservationModel.Reservation]  = [ReservationModel.Reservation(id: 1, roomId: 1, personId: 1, startTime: "11:50", endTime: "12:40", reservationDate: "02.03.2024"), ReservationModel.Reservation(id: 2, roomId: 1, personId: 1, startTime: "14:35", endTime: "15:25", reservationDate: "02.03.2024"),ReservationModel.Reservation(id: 3, roomId: 1, personId: 1, startTime: "08:00", endTime: "08:50", reservationDate: "03.03.2024"),ReservationModel.Reservation(id: 4, roomId: 1, personId: 1, startTime: "11:50", endTime: "12:40", reservationDate: "03.03.2024"),ReservationModel.Reservation(id: 5, roomId: 1, personId: 1, startTime: "07:05", endTime: "07:55", reservationDate: "04.03.2024")
    ]
    
    let dateFormatter1 = DateFormatter()

    
    var times = [
          ["07:05:00","07:55:00"],
          ["08:00:00","08:50:00"],
          ["09:55:00","09:45:00"],
          ["10:00:00","10:50:00"],
          ["10:45:00","11:45:00"],
          ["11:50:00","12:40:00"],
          ["12:45:00","13:35:00"],
          ["13:40:00","14:30:00"],
          ["14:35:00","15:25:00"],
          ["15:30:00","16:20:00"],
          ["16:25:00","17:15:00"],
          ["17:20:00","18:05:00"],
          ["18:05:00","18:50:00"],
          ["19:00:00","19:45:00"],
          ["19:45:00","20:30:00"],
          ["20:40:00","21:25:00"],
          ["21:25:00","22:10:00"]
    
     ]
   
      var dates = [
        "2024-03.01",
        "2024-03-02",
        "2024-03-03",
        "2023-03-04",
        "2024-03-05",
        
      ]
    
    let currentDate = Date()
    
    func getAllDaysOfTheCurrentWeek() -> [Date] {
        
        var dates: [Date] = []
        guard let dateInterval = Calendar.current.dateInterval(of: .weekOfYear, for: Date()) else {
            return dates
        }
        
        Calendar.current.enumerateDates(startingAfter: dateInterval.start, matching: DateComponents(hour:0), matchingPolicy: .nextTime) { date, _, stop in
            guard let date = date else {
                return
            }
            if date <= dateInterval.end {
                dates.append(date)
            }
            else {
                stop = true
            }
        }
        return dates
        
    }
    
    //var currentWeekDays: [Date] = getAllDaysOfTheCurrentWeek()
    
    
   
    
    
    var body: some View{
        let newReservations: [ReservationModel.Reservation] = viewModel.reservations
        let rooms:[String] = viewModelRoom.getRoomNames()
           

        ZStack(alignment: .bottomTrailing) {
        

        VStack(alignment: .leading, spacing: 0){


            
            HStack{
                /*
                Text("Fotostudio")
                    .font(.system(size: 35))
                    .foregroundColor(.white)
                    .padding(.trailing, 50)
                 */
                Picker("", selection: $selection){
                               ForEach(rooms, id: \.self) {
                                   Text($0)
                               }
                           }
                .pickerStyle(.menu)
                
                
                Text(currentDate.formatted(Date.FormatStyle().month(.wide)))
                    .font(.system(size: 25))
                    .foregroundColor(.white)
                    .padding(.leading, 20)

            }.frame(alignment: .leading)
            .frame(width: 395)
            .frame(height: 80)
            .background(Color(red: 30/255, green: 68/255, blue: 77/255, opacity: 1))

            HStack(spacing: 10){
                Group(){
                    Divider()
                        .frame(height: 25.0)
                        .frame(width: 3)
                        .overlay(.gray)
                }.frame(width: 35, alignment: .trailing)
                /*ForEach(1..<6){ number in
                    Group{
                        Text("\(number).")
                            
                        Divider()
                            .frame(height: 25.0)
                            .frame(width: 3)
                            .overlay(.gray)
                    }.frame(width: 30, alignment: .center)
                }*/

                Group{
                    Text("1.")
                        .frame(width: 30)
                    Divider()
                        .frame(height: 25.0)
                        .frame(width: 3)
                        .overlay(.gray)
                }.frame(width: 30, alignment: .center)
                Group{
                    Text("2.")
                        .frame(width: 30)
                    Divider()
                        .frame(height: 25.0)
                        .frame(width: 3)
                        .overlay(.gray)
                }.frame(width: 30)
                Group{
                    Text("3.")
                        .frame(width: 30)
                    Divider()
                        .frame(height: 25.0)
                        .frame(width: 3)
                        .overlay(.gray)

                }.frame(width: 30)
                Group{
                    Text("4.")
                        .frame(width: 30)
                    Divider()
                        .frame(height: 25.0)
                        .frame(width: 3)
                        .overlay(.gray)
                }.frame(width: 30)
                Group{
                    Text("5.")
                        .frame(width: 30)
                }.frame(width: 30)
            }

            HStack(spacing: 10){
                Group{
                    Divider()
                        .frame(height: 20.0)
                        .frame(width: 3)
                        .overlay(.gray)
                }.frame(width: 35, alignment: .trailing)
                Group{
                    Text("MO")
                        .font(.system(size: 14))
                    Divider()
                        .frame(height: 20.0)
                        .frame(width: 3)
                        .overlay(.gray)
                }.frame(width: 30, alignment: .center)
                Group{
                    Text("DI")
                        .frame(width: 50)
                        .font(.system(size: 14))
                    Divider()
                        .frame(height: 20.0)
                        .frame(width: 3)
                        .overlay(.gray)
                }.frame(width: 30)
                Group{
                    Text("MI")
                        .frame(width: 50)
                        .font(.system(size: 14))
                    Divider()
                        .frame(height: 20.0)
                        .frame(width: 3)
                        .overlay(.gray)
                }.frame(width: 30)
                Group{
                    Text("DO")
                        .frame(width: 50)
                        .font(.system(size: 14))
                    Divider()
                        .frame(height: 20.0)
                        .frame(width: 3)
                        .overlay(.gray)
                }.frame(width: 30)
                Group{
                    Text("FR")
                        .frame(width: 50)
                        .font(.system(size: 14))
                }.frame(width: 30)
            }
            Divider()
                .frame(minHeight: 3)
                .overlay(.gray)

            ScrollView{

                VStack( alignment: .leading, spacing: 0){
                    ForEach(0..<17){ number in

                        HStack(spacing: 10){
                            HStack{
                                VStack(spacing: 20){
                                  
                                    Text("\(times[number][0])")
                                        .font(.system(size: 6))
                                        .padding(.leading, 1)
                                        .frame(alignment: .top)
                                    Text("\(times[number][1])")
                                        .font(.system(size: 6))
                                        .frame(alignment: .top)
                                }
                                Divider()
                                    .frame(height: 60.0)
                                    .frame(width: 3)
                                    .overlay(.gray)
                            }.frame(width: 35, alignment: .trailing)
                                .frame(height: 60)

                            ForEach(0..<4){ number2 in

                                Group{
                                    if viewModel.reservations.contains( where: {$0.reservationDate == dates[number2] && $0.startTime == times[number][0] && $0.endTime == times[number][1]})
                                        {
                                        Button {
                                            isActive = true
                                            message = "Your Reservation is on \(dates[number2]) from \(times[number][0]) to \(times[number][1])"
                                            currRes = viewModel.getReservationByDateTime(date: dates[number2], time1: times[number][0], time2: times[number][1])
                                            dateFormatter1.dateFormat = "yyyy-MM-dd"
                                            currdate = dateFormatter1.date(from: dates[number2])!
                                            dateFormatter1.dateFormat = "yyyy-MM-dd HH:mm:ss"
                                            currentDate1 = dateFormatter1.date(from: "\(dates[number2]) \(times[number][0])")!
                                            currentDate2 = dateFormatter1.date(from: "\(dates[number2]) \(times[number][1])")!
                                            
                                        } label: {
                                            ZStack {
                                                RoundedRectangle(cornerRadius: 10)
                                                    .fill(Color(red: 245/255, green: 185/255, blue: 99/255, opacity: 2))
                                                    .frame(width: 70, height: 55, alignment: .leading)
                                            }
                                        }

                                    }else {
                                        RoundedRectangle(cornerRadius: 10)
                                            .fill(.white)
                                    }

                                    Divider()
                                        .frame(height:60.0)
                                        .frame(width: 3)
                                        .overlay(.gray)
                                }.frame(width: 30, alignment: .center)
                            }.frame(width: 30, alignment: .center)
                               

                        }.frame(height: 60)


                        Divider()
                            .frame(minHeight: 3)
                            .overlay(.gray)

                    }
                }
            } .task{
                let reservations = await loadAllReservations(weekDay: "2024-03-01");
                viewModel.reservationLoaded(reservations)
                print(viewModel.reservations)
                
                let rooms = await loadAllRooms();
                viewModelRoom.roomsLoaded(rooms)
                print(viewModelRoom.rooms)
            }
          
        }
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
                          .padding()
            if isActive {
                CustomDialog(isActive: $isActive, title: "Reservation", message: message, buttonTitle: "Edit", action: {
                       isActive2 = true
                    
                }, buttonTitle2: "Delete", action2: {})
                    .zIndex(1)
            }
            
            if isActive2 {
                
                CustomDialogEdit(isActive: $isActive2, title: "Reservation", message: "", buttonTitle: "Speicher", action: {}, currReservation: currRes, currdate: currdate, currentDate1: currentDate1, currentDate2: currentDate2)
            }
            
            if isActive3 {
                
                CustomDialogEdit(isActive: $isActive3, title: "Reservation", message: "", buttonTitle: "Speicher", action: {}, currReservation: nil, currdate: Date.now, currentDate1: Date(), currentDate2: Date())
            }


        }
    }

}

struct CalendarView_Previews: PreviewProvider {
        static var model = ReservationModel()
        static var viewModel = ReservationViewModel(model: model)
    
        static var modelRoom = RoomModel()
        static var viewModelRoom = RoomViewModel(model: modelRoom)
    
        static var previews: some View {
        CalendarView(viewModel: viewModel, viewModelRoom: viewModelRoom)
    }
}

