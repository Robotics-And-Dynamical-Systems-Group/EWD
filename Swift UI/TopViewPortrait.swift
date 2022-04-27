//
//  TopView.swift
//  ePoD
//
//  Created by epod on 3/2/21.
//  Copyright © 2021 Tyler Goudie. All rights reserved.
//

import SwiftUI

let grayGradient = Gradient(colors: [Color(colorGray1),Color(colorGray2)])


struct TopViewPortrait: View {
    
    // Define Timers ############################
    let timerClock = Timer.publish(every: 0.25, on: .main, in: .common).autoconnect()
    
    //Define State Vars ##########################
    @State var time = "00:00:00"
    @State var timeZone = "UTC"
    @State var connectBtnTxt = "Connect to Device"
    @ObservedObject var Settings: AppState = .shared
    @State var showingSettings = false
    @State var ConnectBtnState = 1
    @State var showingConnectAlert = false
    @State var showingBLEPicker = false
    @State var showingBLEProgress = false
    @State var BLEselection = 0
    @State var showingClearDBAlert = false
    @State var showingCSVExport = false
   
    
    
    var body: some View {
        ZStack{
            // Set Background Color 
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
                            if self.Settings.UTCEnabled == true{
                                df.dateFormat = "HH:mm:ss"
                                df.timeZone = NSTimeZone(abbreviation: "UTC") as TimeZone?
                                self.time = df.string(from: date)
                            }
                            if self.Settings.UTCEnabled == false{
                                df.dateFormat = "HH:mm:ss"
                                self.time = df.string(from: date)
                            }
                        }
                        .font(.title)
                        .foregroundColor(.white)
                    
                    // TimeZone
                    Text(timeZone)
                        .onReceive(timerClock) { _ in
                            if self.Settings.UTCEnabled == true{
                                utcFormat = true
                                self.timeZone = "UTC"
                            }
                            if self.Settings.UTCEnabled == false{
                                utcFormat = false
                                self.timeZone = TimeZone.current.abbreviation() ?? "ERR"
                            }
                        }
                        .font(.title)
                        .foregroundColor(.white)
                        .padding(.horizontal,5)
                        .overlay(RoundedRectangle(cornerRadius: 15, style: .continuous)
                                    .stroke(Color.white, lineWidth: 2.0))
                    
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
                            .padding(.leading, 70)
                            
                    }).sheet(isPresented: $showingSettings, content: {
                        SettingsUIView()
                    })
                        
                }.padding(.top,10)
                // *************SECOND H-STACK**************
                HStack{
                    Button(action: {
                        print("Export Button Pressed")
                        
                        CreateCSV()
                    }) {
                        Text("Export to CSV")
                            .foregroundColor(Color.white)
                            .font(.title2)
                            .padding(.top,5)
                            .padding(.bottom, 5)
                            .padding(.horizontal, 20)
                            .overlay(RoundedRectangle(cornerRadius: .infinity, style: .continuous)
                                        .stroke(Color.white, lineWidth: 3.0))
                    }
                    
                    Button(action: {
                        print("Clear DB Button Pressed")
                        self.showingClearDBAlert = true
                    }) {
                        Text("Clear DB")
                            .foregroundColor(Color.white)
                            .font(.title2)
                            .padding(.top,5)
                            .padding(.bottom, 5)
                            .padding(.horizontal, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                            .overlay(RoundedRectangle(cornerRadius: .infinity, style: .continuous)
                                        .stroke(Color.white, lineWidth: 3.0))
                    }.alert(isPresented: $showingClearDBAlert, content: {
                        Alert(title: Text("Database Managment"), message: Text("Are you sure you want to delete ALL Data within the Database?"), primaryButton: .destructive(Text("Yes"), action: {clearDatabase()}), secondaryButton: .cancel())
                    })
                    
                    
                    
                }
                //**************3RD H-STACK*****************
                HStack{
                    Button(action: {
                        if ConnectBtnState == 1 {
                            showingConnectAlert = true
                        }
                        if ConnectBtnState == 3{
                            bluetooth.disconnectPeripheral()
                            ConnectBtnState = 1
                        }
                        
                    }, label: {
                        Text(connectBtnTxt)
                            .foregroundColor(Color.white)
                            .font(.title)
                            .padding(.top,5)
                            .padding(.bottom, 5)
                            .padding(.horizontal, 50)
                            .overlay(RoundedRectangle(cornerRadius: .infinity, style: .continuous)
                                        .stroke(Color.white, lineWidth: 3.0))
                    })
                    
                    
                }.padding(.top,2)
                .padding(.bottom,10)
                .alert(isPresented: $showingConnectAlert, content: {
                    Alert(title: Text("Database Managment"), message: Text("Connecting to a new Device will Delete all Pre-Exisiting data. Do you want to Continue?"), primaryButton: .destructive(Text("Yes"), action: { self.showingBLEPicker = true
                        
                        clearDatabase()
                    }), secondaryButton: .cancel({ConnectBtnState = 1}))
                })
                
            }
        }
        
        if $showingBLEProgress.wrappedValue {
            let progressTimer = Timer.publish(every: 0.25, on: .main, in: .common).autoconnect()
            ZStack{
                Color.white
                
                Circle()
                    .stroke(Color.gray,lineWidth: 20)
                    .padding(30)
                
                Arc(startAngle: .degrees(360), endAngle: .degrees(bleProgress*59), clockWise: false, insetAmount: 10)
                    .stroke(Color.blue ,style: StrokeStyle(lineWidth: 15, lineCap: .round, lineJoin: .bevel))
                    .padding(80)
                
                Text("\(String(format: "%.1f", bleProgress*16.6))%")
                    .font(instntValsFontSize())
                    .foregroundColor(.black)
                
            }.frame(width: 300, height: 150)
            .cornerRadius(20)
            .shadow(radius: 6)
            .onReceive(progressTimer, perform: {_ in
                print("bleProgress===== \(bleProgress)")
                if bleProgress >= 5{
                    self.showingBLEProgress = false
                    
                }
            })
        }
        
        if $showingBLEPicker.wrappedValue {
            ZStack{
                Color.white
                VStack{
                    HStack{
                        Button(action: {
                            if perphNames.isEmpty == false  {
                                print("Selected Bluetooth Peripheral: \(perphNames[self.BLEselection])")
                                
                                let dispatchQueue = DispatchQueue(label: "Selected Bluetooth Queue", qos: .background)
                                dispatchQueue.async {
                                    bluetooth.connectToPerph(peripheral: peripherals[self.BLEselection])
                                    
                                }
                                self.showingBLEPicker.toggle()
                                self.ConnectBtnState = 3
                                self.showingBLEProgress.toggle()
                            }
                        }, label: {
                            Text("Done")
                                .font(.system(size: 16))
                                .foregroundColor(.blue)
                            
                            
                        })
                        
                        Button(action: {print("Cancel")
                            self.showingBLEPicker.toggle()
                            self.ConnectBtnState = 1
                        }, label: {
                            Text("Cancel")
                                .font(.system(size: 16))
                                .foregroundColor(.red)
                        }).offset(x: 160)
                        
                    }.position(x: 70, y: 12)
                    
                    Picker("BLE Devices", selection: $BLEselection, content: {
                        ForEach(0 ..< perphNames.count){
                            index in Text(perphNames[index]).tag(index).font(.system(size: 16)).foregroundColor(Color.black)
                        }
                    }).pickerStyle(SegmentedPickerStyle())
                    .frame(width: 300, height: 140)
                }
            }
            .frame(width: 300, height: 150)
            .cornerRadius(20)
            //.position(x: screenSize.width * 0.5, y: 0)
            .shadow(radius: 6)
        }
    }
}

struct TopView_Previews: PreviewProvider {
    static var previews: some View {
        TopViewPortrait()
        
    }
}


