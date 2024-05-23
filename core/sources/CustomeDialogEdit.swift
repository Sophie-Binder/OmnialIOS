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
    @State private var selection = "Fotostudio"
    @State  var currdate: Date
    @State  var currentDate1: Date
    @State  var currentDate2: Date
    

    
    
    let rooms = ["Fotostudio", "Musikraum", "Vioschnittraum"]
    
   
    
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
                
                DatePicker("Select starting Time", selection: $currentDate1, displayedComponents: .hourAndMinute)
                DatePicker("Select ending Time", selection: $currentDate2, displayedComponents: .hourAndMinute)

                
                Button {
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
        CustomDialogEdit(isActive: .constant(true), title: "Reservation", message: "Your Reservation is on in ", buttonTitle: "OK", action: {}, currReservation: nil, currdate: Date.now, currentDate1: Date(), currentDate2: Date())
    }
}
