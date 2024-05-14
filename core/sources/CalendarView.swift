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
    @State var message: String = ""
    @State var isActive: Bool = false
    
 
    
    
    let reservations: [ReservationModel.Reservation]  = [ReservationModel.Reservation(id: 1, roomId: 1, personId: 1, time1: "11:50", time2: "12:40", date: "02.03.2024"), ReservationModel.Reservation(id: 2, roomId: 1, personId: 1, time1: "14:35", time2: "15:25", date: "02.03.2024"),ReservationModel.Reservation(id: 3, roomId: 1, personId: 1, time1: "08:00", time2: "08:50", date: "03.03.2024"),ReservationModel.Reservation(id: 4, roomId: 1, personId: 1, time1: "11:50", time2: "12:40", date: "03.03.2024"),ReservationModel.Reservation(id: 5, roomId: 1, personId: 1, time1: "07:05", time2: "07:55", date: "04.03.2024")
    ]
    

    
    var times = [
          ["07:05","07:55"],
          ["08:00","08:50"],
          ["09:55","09:45"],
          ["10:00","10:50"],
          ["10:45","11:45"],
          ["11:50","12:40"],
          ["12:45","13:35"],
          ["13:40","14:30"],
          ["14:35","15:25"],
          ["15:30","16:20"],
          ["16:25","17:15"],
          ["17:20","18:05"],
          ["18:05","18:50"],
          ["19:00","19:45"],
          ["19:45","20:30"],
          ["20:40","21:25"],
          ["21:25","22:10"]
    
     ]
   
      var dates = [
        "01.03.2024",
        "02.03.2024",
        "03.03.2024",
        "04.03.2024",
        "05.03.2024",
        
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

        ZStack {
        

        VStack(alignment: .leading, spacing: 0){



            HStack{
                Text("Fotostudio")
                    .font(.system(size: 35))
                    .foregroundColor(.white)
                    .padding(.trailing, 50)
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
                                    if reservations.contains( where: {$0.date == dates[number2] && $0.time1 == times[number][0] && $0.time2 == times[number][1]})
                                        {
                                        Button {
                                            isActive = true
                                            message = "Your Reservation is on in \(dates[number2]) from \(times[number][0]) to \(times[number][1])"
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
                                .task{
                                    let reservations = await loadAllReservations(weekDay: "01.04.2023");
                                    viewModel.reservationLoaded(reservations)
                                }

                        }.frame(height: 60)


                        Divider()
                            .frame(minHeight: 3)
                            .overlay(.gray)

                    }
                }
            }


            /*HStack(spacing: 10){times[number][0] == reservations[0].time1 && times[number][1] == reservations[0].time2 && dates[number2] == reservations[0].date
                HStack{
                    VStack(spacing: 20){
                            Text("07:05")
                                .frame( alignment: .top)
                                .font(.system(size: 7))
            
                            Text("07:55")
                                .frame( alignment: .bottom)
                                .font(.system(size: 7))
                    }.frame(width: 20)
                    Divider()
                        .frame(height: 40.0)
                        .frame(width: 5)
                        .overlay(.gray)
                }.frame(width: 25, alignment: .trailing)
                    .border(Color.green)
                
                Group{
                    Divider()
                        .frame(height: 20.0)
                        .frame(width: 5)
                        .overlay(.gray)
                }.frame(width: 25, alignment: .trailing)
                    .border(Color.red)
                
                Group{
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.white)
                    Divider()
                        .frame(height: 50.0)
                        .frame(width: 5)
                        .overlay(.gray)
                }.frame(width: 30)
                
                Group{
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.white)
                        .frame(width: 40)
                    Divider()
                        .frame(height: 50.0)
                        .frame(width: 5)
                        .overlay(.gray)
                }.frame(width: 30)
                
                Group{
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.white)
                        .frame(width: 40)
                    Divider()
                        .frame(height: 50.0)
                        .frame(width: 5)
                        .overlay(.gray)
                }
                Group{
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.white)
                        .frame(width: 40)
                    Divider()
                        .frame(height: 50.0)
                        .frame(width: 5)
                        .overlay(.gray)
                }
                Group{
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.white)
                        .frame(width: 40)
                }
            }.frame(height: 50, alignment: .center)
            Divider()
                .frame(minHeight: 5)
                .overlay(.gray)*/
        }
            if isActive {
                CustomDialog(isActive: $isActive, title: "Reservation", message: message, buttonTitle: "OK", action: {print("Works")})
                    .zIndex(1)
            }

        }
    }

}

struct CalendarView_Previews: PreviewProvider {
    static var model = ReservationModel()
        static var viewModel = ReservationViewModel(model: model)
        static var previews: some View {
        CalendarView(viewModel: viewModel)
    }
}

