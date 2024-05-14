//
//  CustomDialog.swift
//  Ominal
//
//  Created by Sophie Binder on 14.05.24.
//

import Foundation
import SwiftUI

struct CustomDialog: View{
    
    @Binding var isActive: Bool
    
    let title: String
    let message: String
    let buttonTitle: String
    let action: () -> ()
    @State private var offset: CGFloat = 1000
    
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

struct CustomDialog_Previews: PreviewProvider {
    static var previews: some View {
        CustomDialog(isActive: .constant(true), title: "Reservation", message: "Your Reservation is on in ", buttonTitle: "OK", action: {})
    }
}
