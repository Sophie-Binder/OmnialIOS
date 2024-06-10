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
  
    
    
    let reservations: [ReservationModel.Reservation]  = [ReservationModel.Reservation(id: 1, roomId: 1, personId: 1, startTime: "11:50", endTime: "12:40", reservationDate: "02.03.2024"), ReservationModel.Reservation(id: 2, roomId: 1, personId: 1, startTime: "14:35", endTime: "15:25", reservationDate: "02.03.2024"),ReservationModel.Reservation(id: 3, roomId: 1, personId: 1, startTime: "08:00", endTime: "08:50", reservationDate: "03.03.2024"),ReservationModel.Reservation(id: 4, roomId: 1, personId: 1, startTime: "11:50", endTime: "12:40", reservationDate: "03.03.2024"),ReservationModel.Reservation(id: 5, roomId: 1, personId: 1, startTime: "07:05", endTime: "07:55", reservationDate: "04.03.2024")
    ]
    
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
   
      var dates = [
        "2024-03-01",
        "2024-03-02",
        "2024-03-03",
        "2023-03-04",
        "2024-03-05",
        
      ]
    
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
    
    func convertNextDate(dateString : String)-> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let myDate = dateFormatter.date(from: dateString)!
        let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: myDate)
        let somedateString = dateFormatter.string(from: tomorrow!)
        return somedateString
    }

    func toStringDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let firstDayString = dateFormatter.string(from: date)
        return firstDayString
    }
    
    func getFirstDay() ->  [String]{
        let firstDay = Date().startOfWeek()
        let Sunday = toStringDate(date: firstDay)
        let Monday = convertNextDate(dateString: Sunday)
        let Tuesday = convertNextDate(dateString: Monday)
        let Wednesday = convertNextDate(dateString: Tuesday)
        let Thursday = convertNextDate(dateString: Wednesday)
        let Friday = convertNextDate(dateString: Thursday)

        let days: [String] = [Monday, Tuesday, Wednesday, Thursday, Friday]
        print(days)
        return days
    }
    
    
    
    
    var body: some View{
        
        let days: [String] = getFirstDay()
        
        
        
        
        //let newReservations: [ReservationModel.Reservation] = viewModel.reservations
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
            .frame(maxWidth: .infinity)
            .frame(height: 80)
            .background(Color(red: 30/255, green: 68/255, blue: 77/255, opacity: 1))

            HStack(spacing: 10){
                
                Group(){
                    Divider()
                        .frame(height: 25.0)
                        .frame(width: 3)
                        .overlay(.gray)
                }.frame(width: 35, alignment: .trailing)
                
                
                ForEach(1..<6, id: \.self) { offset in
                    
                    
                    Group{
                        Text(String(self.dateString(for: offset).suffix(2)))
                        Divider()
                            .frame(height: 25.0)
                            .frame(width: 3)
                            .overlay(.gray)
                    }.frame(width: 30, alignment: .center)
                    
                }
                

                
                /*
                ForEach(days) {day in
                    Group{
                        Text("\(String(day.suffix(2)))")
                            .frame(width: 30)
                        Divider()
                            .frame(height: 25.0)
                            .frame(width: 3)
                            .overlay(.gray)
                    }.frame(width: 30, alignment: .center)
                }
            
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
                */
                
                
            }.frame(maxWidth: .infinity)

            HStack(spacing: 10){
                Group(){
                    Divider()
                        .frame(height: 25.0)
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
                    Divider()
                        .frame(height: 25.0)
                        .frame(width: 3)
                        .overlay(.gray)
                }.frame(width: 30)
                
                
                
                
            }.frame(maxWidth: .infinity)
            
            
            Divider()
                .frame(minHeight: 3)
                .overlay(.gray)

            ScrollView{

                VStack(  alignment: .leading,spacing: 0 ){
                    ForEach(0..<17){ number in

                        HStack(spacing: 10){
                           
                                VStack(spacing: 20){
                                  
                                    Text("\(times[number][0])")
                                        .font(.system(size: 6))
                                        .padding(.leading, 1)
                                        .frame(alignment: .top)
                                    Text("\(times[number][1])")
                                        .font(.system(size: 6))
                                        .frame(alignment: .bottom)
                                }.frame(width: 25,alignment: .leading)
                                Divider()
                                    .frame(height: 60.0)
                                    .frame(width: 3)
                                    .overlay(.gray)
                           

                            ForEach(0..<4){ number2 in

                                Group{
                                    if viewModel.reservations.contains( where: {$0.reservationDate == dates[number2] && $0.startTime == times[number][0] && $0.endTime == times[number][1] && $0.roomId == viewModelRoom.getIdByName(name: selection)})
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
                }.frame(maxWidth: .infinity)
                    .gesture(
                        DragGesture()
                            .onEnded { value in
                                if value.translation.width < 0 {
                                    // Swipe left
                                    self.currentWeek = self.changeWeek(by: 1)
                                    print("!!!!\(currentWeek)")
                                } else if value.translation.width > 0 {
                                    // Swipe right
                                    self.currentWeek = self.changeWeek(by: -1)
                                    print("!!!!\(currentWeek)")
                                }
                            }
                    )
            } .task{
                let reservations = await loadAllReservations(weekDay: "2024-03-01");
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
                             let reservations = try await loadAllReservations(weekDay: "2024-03-01");
                             viewModel.reservationLoaded(reservations)
                             print("DFFGDERFG")
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
                             let reservations = try await loadAllReservations(weekDay: "2024-03-01");
                             viewModel.reservationLoaded(reservations)
                             print("DFFGDERFG")
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
                             let reservations = try await loadAllReservations(weekDay: "2024-03-01");
                             viewModel.reservationLoaded(reservations)
                             print("DFFGDERFG")
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
        print("wichtig::")
        print(formatter.string(from: date))
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

