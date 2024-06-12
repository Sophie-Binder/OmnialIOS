//
//  CustomDialog.swift
//  Ominal
//
//  Created by Sophie Binder on 14.05.24.
//

import Foundation
import SwiftUI

struct CustomDialogEdit: View{
    
    @Binding var isActive: Bool
    //@Binding var reservation: ReservationModel.Reservation
    
    let title: String
    let message: String
    let buttonTitle: String
    let action: () -> ()
    let currReservation: ReservationModel.Reservation?
    @State private var offset: CGFloat = 1000
    @Binding var selection: String
    @Binding  var currdate: Date
    @Binding  var currentDate1: Date
    @Binding  var currentDate2: Date
    
    let rooms = ["Fotostudio", "Musikraum", "Videoschnittraum"]
    
    @State private var selectedTime = 0
    
    @State private var selectedTime2 = 0
    
    let dateFormatter = DateFormatter()
    
       

    let allowedTimes = ["07:05","08:00","08:55","10:00", "10:55", "11:50", "12:45", "13:40", "14:35", "15:30", "16:25", "17:20", "18:05", "19:00", "19:45", "20:40","21:25"]
    let allowedTimes2 = ["07:55","08:50","09:45","10:50", "11:45", "12:40", "13:35", "14:30", "15:25", "16:20", "17:15", "18:05", "18:50", "19:45","20:30","21:25", "22:10"]
    
    func timeConversion12(time24: String) -> String {
        let dateAsString = time24
        let df = DateFormatter()
        df.dateFormat = "HH:mm"

        let date = df.date(from: dateAsString)
        df.dateFormat = "hh:mm a"

        let time12 = df.string(from: date!)
        print(time12)
        return time12
    }
    
       
    
    var body: some View {
        
        ZStack {
          
            
            Color(.white)
                .opacity(0.1)
                .onTapGesture {
                    close()
                }
            VStack{
            
                
                Text(title)
                    .font(.title2)
                    .bold()
                    .padding()
                Text(message)
                    .font(.body)
                
                
                Picker("Select a room", selection: $selection) {
                               ForEach(rooms, id: \.self) {
                                   Text($0)
                               }
                           }
                           .pickerStyle(.menu)
                
                DatePicker(selection: $currdate, displayedComponents: .date) {
                                Text("Select a date")
                            }
                
               /* DatePicker("Select starting Time", selection: $currentDate1, displayedComponents: .hourAndMinute)*/
               // DatePicker("Select ending Time", selection: $currentDate2, displayedComponents: .hourAndMinute)
                
                
                
                Picker("Select a time", selection: $selectedTime) {
                                ForEach(0..<allowedTimes.count) { index in
                                    Text(self.allowedTimes[index]).tag(index)
                                    
                                }
                }
                
                Picker("Select a time", selection: $selectedTime2) {
                                ForEach(0..<allowedTimes2.count) { index in
                                    Text(self.allowedTimes2[index]).tag(index)
                                    
                                }
                }

                
                Button {
                    dateFormatter.dateFormat = "HH:mm"
            
                    currentDate1 = dateFormatter.date(from: allowedTimes[selectedTime])!
                    currentDate2 = dateFormatter.date(from: allowedTimes2[selectedTime2])!
                    action()
                    close()
                } label: {
                    ZStack {
                        Text(buttonTitle)
                            .font(.system(size: 16, weight: .bold))
                            .padding()
                    }
                    .padding()
                }
                
            }
            .zIndex(1)
            .fixedSize(horizontal: false, vertical: true)
            .padding()
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .overlay{
                VStack{
                    HStack {
                        Spacer()
                        Button{
                            close()
                        } label: {
                            Image(systemName: "xmark")
                                .font(.title2)
                        }
                        .tint(.black)
                        
                    }
                    
                    Spacer()
                }.padding()
            }
            .shadow(radius: 30)
            .padding(30)
            .offset(x: 0, y: offset)
            .onAppear {
                withAnimation(.spring()) {
                offset = 0
                }
            }
        }
    }
    
    
    func close() {
        withAnimation(.spring()) {
            offset = 1000
            isActive = false
        }
        
    }

}

struct CustomDialogEdit_Previews: PreviewProvider {
    static var previews: some View {
        CustomDialogEdit(isActive: .constant(true), title: "Reservation", message: "Your Reservation is on in ", buttonTitle: "OK", action: {}, currReservation: nil, selection: .constant("Fotostudio") ,currdate: .constant(Date.now), currentDate1: .constant(Date()), currentDate2: .constant(Date()))
    }
}
