//
//  SideTopViewLandscape.swift
//  ePoD
//
//  Created by epod on 3/9/21.
//  Copyright © 2021 Tyler Goudie. All rights reserved.
//

import SwiftUI

struct SideTopViewLandscape: View {
    
    // Define Timers ############################
    let timerClock = Timer.publish(every: 0.25, on: .main, in: .common).autoconnect()
    
    //Define State Vars ##########################
    @State var time = "00:00:00"
    @State var timeZone = "UTC"
    @State var connectBtnTxt = "Connect"
    @State var UTCEnabled = true
    @State var showingSettings = false
    @State var ConnectBtnState = false
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(LinearGradient(gradient: grayGradient, startPoint: .topLeading, endPoint: .bottomTrailing)).cornerRadius(20)
        
            VStack{
                //*************1ST H-Stack*****************
                HStack{
                    // Time in HH:MM:SS format
                    Text(time)
                        .onReceive(timerClock) { _ in
                            let date = Date()
                            let df = DateFormatter()
                            if self.UTCEnabled == true{
                                df.dateFormat = "HH:mm:ss"
                                df.timeZone = NSTimeZone(abbreviation: "UTC") as TimeZone?
                                self.time = df.string(from: date)
                            }
                            if self.UTCEnabled == false{
                                df.dateFormat = "HH:mm:ss"
                                self.time = df.string(from: date)
                            }
                        }
                        .font(.title3)
                        .foregroundColor(.white)
                    
                    // TimeZone
                    Text(timeZone)
                        .onReceive(timerClock) { _ in
                            if self.UTCEnabled == true{
                                utcFormat = true
                                self.timeZone = "UTC"
                            }
                            if self.UTCEnabled == false{
                                utcFormat = false
                                self.timeZone = TimeZone.current.abbreviation() ?? "ERR"
                            }
                        }
                        .font(.title3)
                        .foregroundColor(.white)
                        .padding(.horizontal,5)
                        .overlay(RoundedRectangle(cornerRadius: 15, style: .continuous)
                                    .stroke(Color.white, lineWidth: 2.0))
                    
                   
                        
                }.padding(.top,0)
                // *************SECOND H-STACK**************
                HStack{
                    Button(action: {
                        print("Export Button Pressed")
                        
                        //CreateCSV()
                    }) {
                        Text("Export")
                            .foregroundColor(Color.white)
                            .font(.title3)
                            .padding(.top,5)
                            .padding(.bottom, 5)
                            .padding(.horizontal, 10)
                            .overlay(RoundedRectangle(cornerRadius: .infinity, style: .continuous)
                                        .stroke(Color.white, lineWidth: 3.0))
                    }
                    
                    //Settings Button
                    Button(action: {
                    // call settings view
                        print("Settings Button Pressed")
                        self.showingSettings = true
                    },
                    label: {
                        Image("settingsIcon2")
                            .resizable()
                            .frame(width: 40, height: 40)
                            .colorInvert()
                            .padding(.leading,30)
                            
                    })
                    
                   
                    
                    
                    
                }
                //**************3RD H-STACK*****************
                HStack{
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                        Text(connectBtnTxt)
                            .foregroundColor(Color.white)
                            .font(.title3)
                            .padding(.top,5)
                            .padding(.bottom, 5)
                            .padding(.horizontal, 10)
                            .overlay(RoundedRectangle(cornerRadius: .infinity, style: .continuous)
                                        .stroke(Color.white, lineWidth: 3.0))
                    })
                    
                    Button(action: {
                        print("Clear DB Button Pressed")
                        //self.showingClearDBAlert = true
                    }) {
                        Text("Clr DB")
                            .foregroundColor(Color.white)
                            .font(.title3)
                            .padding(.top,5)
                            .padding(.bottom, 5)
                            .padding(.horizontal, 5)
                            .overlay(RoundedRectangle(cornerRadius: .infinity, style: .continuous)
                                        .stroke(Color.white, lineWidth: 3.0))
                    }//.alert(isPresented: $showingClearDBAlert, content: {
                       // Alert(title: Text("Database Managment"), message: Text("Are you sure you want to delete ALL Data within the Database?"), primaryButton: .destructive(Text("Yes"), action: {clearDatabase()}), secondaryButton: .cancel())
                    //})
                    
                    
                }
            }
            
        }
    }
}

struct SideTopViewLandscape_Previews: PreviewProvider {
    static var previews: some View {
        SideTopViewLandscape()
    }
}
