//
//  CalendarView.swift
//  omnial
//
//  Created by Binder Sophie on 07.03.24.
//

import Foundation
import SwiftUI
import UIKit


extension Calendar {
    static let gregorian = Calendar(identifier: .gregorian)
}

extension Date {
    func startOfWeek(using calendar: Calendar =  Calendar.current) -> Date {
        calendar.dateComponents([.calendar, .yearForWeekOfYear, .weekOfYear], from: self).date!
    }
}

extension String: Identifiable {
    public typealias ID = Int
    public var id: Int {
        return hash
    }
}


struct CalendarView: View {
    
    @State private var currentWeek: Date = Date()

    
    
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
    
    @State var selection = "Fotostudio"
  
    

    let dateFormatter1 = DateFormatter()
    let dateFormatter2 = DateFormatter()
    

    
    var times = [
          ["07:05:00","07:55:00"],
          ["08:00:00","08:50:00"],
          ["08:55:00","09:45:00"],
          ["10:00:00","10:50:00"],
          ["10:55:00","11:45:00"],
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
    
    
    
    func fillUpArray() -> [String]{
        var weekDay:[String] = []
        for index in (1...5) {
            weekDay.append(dateString(for: index))
        }
        print(weekDay)
        return weekDay
    }
    

   
    
    func serverToLocalTime(date:String) -> Date? {
        
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSSSSS Z"
        dateFormatter.timeZone = TimeZone(abbreviation: "CET")
        
        dateFormatter.timeZone = TimeZone.current
        let date = dateFormatter.date(from: date)
        let timeStamp = dateFormatter.string(from: date!)
        print(date!)
        return date
    
       
    }
    
    func serverToLocal(date:String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        let localDate = dateFormatter.date(from: date)

        return localDate
    }
    
    let currentDate = Date()
    

    
    //var currentWeekDays: [Date] = getAllDaysOfTheCurrentWeek()

    
    
    
    
    var body: some View{
        var weekDay:[String] = fillUpArray()
        
        //let days: [String] = getFirstDay()
        
        
        
        
        //let newReservations: [ReservationModel.Reservation] = viewModel.reservations
        let rooms:[String] = viewModelRoom.getRoomNames()
           

        ZStack(alignment: .bottomTrailing) {
        

        VStack(alignment: .leading, spacing: 0){


            
            HStack{
                
                Picker("", selection: $selection){
                               ForEach(rooms, id: \.self) {
                                   Text($0)
                               }
                           }
                .pickerStyle(.menu)
                
                
                Text(currentWeek.formatted(Date.FormatStyle().month(.wide)))
                    .font(.system(size: 25))
                    .foregroundColor(.white)
                    .padding(.leading, 20)
                
            }.frame(alignment: .leading)
            .frame(maxWidth: .infinity)
            .frame(height: 80)
            .background(Color(red: 30/255, green: 68/255, blue: 77/255, opacity: 1))

            HStack(spacing: 0){
                
              
                
                
                ForEach(1..<6, id: \.self) { offset in
                    
                    if(offset == 1){
                        Spacer().frame(width: 40)
                         

                    }
                    
                    Divider()
                        .frame(height: 25.0)
                        .frame(width: 3)
                        .overlay(.gray)
                        Text(String(self.dateString(for: offset).suffix(2)))
                        .frame(maxWidth: .infinity)
                    
                }
                Divider()
                    .frame(height: 25.0)
                    .frame(width: 3)
                    .overlay(.gray)
                    
                
                
            }.frame(maxWidth: .infinity, alignment: .center)

            HStack(spacing: 0){
            
                Spacer().frame(width: 40)
                
                Divider()
                    .frame(height: 25.0)
                    .frame(width: 3)
                    .overlay(.gray)
                
                Text("MO")
                    .font(.system(size: 14))
                    .frame(maxWidth: .infinity)
                
                Divider()
                    .frame(height: 25.0)
                    .frame(width: 3)
                    .overlay(.gray)
                
                Text("DI")
                    .font(.system(size: 14))
                    .frame(maxWidth: .infinity)
                
                
                Divider()
                    .frame(height: 25.0)
                    .frame(width: 3)
                    .overlay(.gray)
                
                Text("MI")
                    .font(.system(size: 14))
                    .frame(maxWidth: .infinity)
                
                
                Divider()
                    .frame(height: 25.0)
                    .frame(width: 3)
                    .overlay(.gray)
                
                Text("DO")
                    .font(.system(size: 14))
                    .frame(maxWidth: .infinity)
                
                Group{
                Divider()
                    .frame(height: 25.0)
                    .frame(width: 3)
                    .overlay(.gray)
                
                Text("DO")
                    .font(.system(size: 14))
                    .frame(maxWidth: .infinity)
                    Divider()
                        .frame(height: 25.0)
                        .frame(width: 3)
                        .overlay(.gray)
                }
                
                
                
 
            }.frame(maxWidth: .infinity, alignment: .center)
            
            
            Divider()
                .frame(minHeight: 3)
                .overlay(.gray)

            ScrollView{

                VStack(spacing: 0 ){
                    ForEach(0..<17){ number in

                        HStack(spacing: 0){
                           
                
                                VStack(spacing: 20){
                                  
                                    Text("\(String(times[number][0].prefix(5)))")
                                        .font(.system(size: 6))
                                        .padding(.leading, 1)
                                        .frame(alignment: .top)
                                    Text("\(String(times[number][1].prefix(5)))")
                                        .font(.system(size: 6))
                                        .frame(alignment: .bottom)
                                  
                                }.frame(width:40)
                            Divider()
                                .frame(height: 60.0)
                                .frame(width: 3)
                                .overlay(.gray)

                            ForEach(0..<5){ number2 in

                               
                                    if viewModel.reservations.contains( where: {$0.reservationDate == weekDay[number2] && $0.startTime == times[number][0] && $0.endTime == times[number][1] && $0.roomId == viewModelRoom.getIdByName(name: selection)})
                                        {
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
                                        }

                                    }else {
                                        RoundedRectangle(cornerRadius: 10)
                                            .fill(.white)
                                    }

                                    Divider()
                                        .frame(height:60.0)
                                        .frame(width: 3)
                                        .overlay(.gray)
                         
                            }
                               

                        }.frame( height: 60 , alignment: .leading)
                            

                        Divider()
                            .frame(minHeight: 3)
                            .overlay(.gray)

                    }
                }.frame(maxWidth: .infinity, alignment: .leading)
                    .gesture(
                        DragGesture()
                            .onEnded { value in
                                if value.translation.width < 0 {
                                    // Swipe left
                                    self.currentWeek = self.changeWeek(by: 1)
                                    
                                } else if value.translation.width > 0 {
                                    // Swipe right
                                    self.currentWeek = self.changeWeek(by: -1)
                                    
                                }
                            }
                    )
            } .task{
                let reservations = await loadAllReservations(weekDay: dateString(for: 1));
                viewModel.reservationLoaded(reservations)
                print(viewModel.reservations)
                
                let rooms = await loadAllRooms();
                viewModelRoom.roomsLoaded(rooms)
                print(viewModelRoom.rooms)
            }
            .frame(maxWidth: .infinity)
          
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
                    
                }, buttonTitle2: "Delete", action2: {
                    
                    deleteReservation(id: currRes.id)
                    
                    Task {
                         do {
                             try await Task.sleep(nanoseconds: 1_000_000_000)
                             let reservations = try await loadAllReservations(weekDay: dateString(for: 1));
                             print("-----")
                             print(reservations)
                             print("-----")
                             viewModel.reservationLoaded(reservations)
                             
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
                             let reservations = try await loadAllReservations(weekDay: dateString(for: 1));
                             viewModel.reservationLoaded(reservations)
                           
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
                    
                    addReservation(reservation: ReservationModel.Reservation(roomId: viewModelRoom.getIdByName(name: selection), personId: 1, startTime: dateFormatter2.string(from: currdate)+dateFormatter1.string(from: currentDate1), endTime: dateFormatter2.string(from: currdate)+dateFormatter1.string(from: currentDate2), reservationDate: dateFormatter2.string(from: currdate)))
                    
                    currdate = Date.now
                    currentDate1 = Date.now
                    currentDate2 = Date.now
                    
                    


                    Task {
                         do {
                             try await Task.sleep(nanoseconds: 1_000_000_000)
                             let reservations = try await loadAllReservations(weekDay: dateString(for: 1));
                             viewModel.reservationLoaded(reservations)
                        
                         }
                         catch {
                             print(error)
                         }
                     }
                    //let reservations = try? await loadAllReservations(weekDay: "2024-03-01");
                    
                }, currReservation: nil, selection: $selection, currdate: $currdate, currentDate1: $currentDate1, currentDate2: $currentDate2)
            }


        }
        
    }
    private func dateString(for offset: Int) -> String {
        let calendar = Calendar.current
        let startOfWeek = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: currentWeek))!
        let date = calendar.date(byAdding: .day, value: offset, to: startOfWeek)!
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: date)
    }

    private func changeWeek(by weeks: Int) -> Date {
        let calendar = Calendar.current
        return calendar.date(byAdding: .weekOfYear, value: weeks, to: currentWeek)!
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

