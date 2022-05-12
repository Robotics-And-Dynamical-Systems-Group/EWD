//
//  HomeUIView.swift
//  ePoD
//
//  Created by Tyler Goudie on 6/30/20.
//  Copyright © 2020 Tyler Goudie. All rights reserved.
//

import SwiftUI
import SwiftUICharts


var topGraphDataSelector = 2
var botGraphDataSelector = 1
var graphStyles = [GraphStylePurple,GraphStyleBlu,GraphStyleGreen,GraphStyleOrange,GraphStyleBluPurpl,GraphStylePrplPink,GraphStyleOrngPink,GraphStyleBlack]



struct HomeUIView: View {
    
    @State var showingBLEProgress = false
    @State var showingBLEPicker = false
    @State var showingLFG = false
    @State var showingSettings = false
    @State var showingConnectAlert = false
    @State var showingClearDBAlert = false
    @State var showingCSVExport = true
    @State var UTCEnabled = true
    @State var tempSelection = ["F°","C°","K°"]
    @State var tempSelected = 0
    @State var BLEselection = 0
    @State var GraphStyleSelected = 0
    @State var time = String()
    @State var timeZone = String()
    @State var gxVal = String()
    @State var gyVal = String()
    @State var gzVal = String()
    @State var sp02Val = String()
    @State var bpmVal = String()
    @State var tempVal = String()
    @State var ConnectBtnState = 1
    @State var TopGraphData = RandomArray
    @State var TopGraphTitle = "PPG"
    @State var BotGraphData = RandomArray
    @State var BotGraphTitle = "SP02"
    @State var EKGGraphTitle = "EKG"
    @State var EKGGraphData = RandomArray
    @State var Tb1 = false
    @State var Tb2 = true
    @State var Tb3 = false
    @State var Tb4 = false
    @State var Tb5 = false
    @State var Tb6 = false
    @State var Bb1 = true
    @State var Bb2 = false
    @State var Bb3 = false
    @State var Bb4 = false
    @State var Bb5 = false
    @State var Bb6 = false
    
    let timerInstntVals = Timer.publish(every: 0.25, on: .main, in: .common).autoconnect()
    
    let topGraphTimer = Timer.publish(every: 0.05, on: .main, in: .common).autoconnect()
    let botGraphTimer = Timer.publish(every: 0.05, on: .main, in: .common).autoconnect()
    let EKGGraphTimer = Timer.publish(every: 0.05, on: .main, in: .common).autoconnect()
    var body: some View {
        
//      added scrollView for adding new ekg stack
        ScrollView{
        ZStack{
            Color.white
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 10){
                    VStack(alignment:.center){
                        HStack{
                            // Time in HH:MM:SS format
                            Text(time)
                                .onReceive(timerInstntVals) { _ in
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
                                .foregroundColor(.white)
                                .font(instntLabelsFontSize())
                                .offset(x: -60)

                            // TimeZone
                            Text(timeZone)
                                .onReceive(timerInstntVals) { _ in
                                    if self.UTCEnabled == true{
                                        utcFormat = true
                                        self.timeZone = "UTC"
                                    }
                                    if self.UTCEnabled == false{
                                        utcFormat = false
                                        self.timeZone = TimeZone.current.abbreviation() ?? "ERR"
                                    }
                                }
                                .foregroundColor(.white)
                                .font(instntLabelsFontSize())
                                .padding(EdgeInsets(top: 2, leading: 3, bottom: 2, trailing: 3))
                                .overlay(RoundedRectangle(cornerRadius: 7, style: .continuous)
                                            .stroke(Color.white, lineWidth: 2.0))
                                .offset(x: -30)

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

                            }).offset(x:60)
                        }
                        .sheet(isPresented: $showingSettings, content: {
                            SettingsUIView()
                        })
                        //.sheet(isPresented: $showingSettings, content: {SettingsUIView()})
                        //.sheet(isPresented: $showingSettings, content: {SettingsUIView(enable: $UTCEnabled, selected: $tempSelected, GsSelected: $GraphStyleSelected)})
                        HStack{
                            Text("BPM:")
                                .foregroundColor(.white)
                                .font(instntLabelsFontSize())
                                .underline()
                            Text(bpmVal)
                                .onReceive(timerInstntVals) { _ in
                                    if currentBPM > 250 || currentBPM < 0{
                                        self.bpmVal = "err"
                                    }
                                    if currentBPM <= 250 && currentBPM >= 0{
                                        self.bpmVal = "\(Int(currentBPM))"
                                    }
                                }
                                .foregroundColor(.white)
                                .font(instntValsFontSize2())
                            Text("SP02:")
                                .foregroundColor(.white)
                                .font(instntLabelsFontSize())
                                .underline()
                            Text(sp02Val)
                                .onReceive(timerInstntVals) { _ in
                                    if currentSp02 > 200 || currentSp02 < 0{
                                        self.sp02Val = "err"
                                    }
                                    if currentSp02 <= 200 && currentSp02 >= 0{
                                        self.sp02Val = "\(Int(currentSp02))%"
                                    }
                                }
                                .foregroundColor(.white)
                                .font(instntValsFontSize2())
                            Text("\(tempSelection[self.tempSelected]):")
                                .foregroundColor(.white)
                                .font(instntLabelsFontSize())
                                .underline()
                            Text(tempVal)
                                .onReceive(timerInstntVals) { _ in
                                    if currentTemp > 1000 || currentTemp < -50{
                                        self.tempVal = "err"
                                    }
                                    if currentTemp <= 1000 && currentTemp >= -50{

                                        switch self.tempSelected {
                                        case 0:
                                            self.tempVal = "\((currentTemp))"
                                           // print("F")
                                        case 1:
                                            self.tempVal = "\(((currentTemp-32.0)*0.55555).rounded(toPlaces: 1))"
                                            //print("C")
                                        case 2:
                                            self.tempVal = "\((((currentTemp-32)*(0.55555))+273.15).rounded(toPlaces: 1))"
                                            //print("K")
                                        default:
                                            self.tempVal = "\(Int(currentTemp))"
                                            //print("F")
                                        }
                                    }
                                }
                                .foregroundColor(.white)
                                .font(instntValsFontSize2())
                        }
                        HStack{
                            Text("g-x:")
                                .foregroundColor(.white)
                                .font(instntLabelsFontSize())
                                .underline()
                            Text(gxVal)
                                .onReceive(timerInstntVals) { _ in
                                    if currentAx > 16 || currentAx < -16{
                                        self.gxVal = "err"
                                    }
                                    if currentAx <= 16 && currentAx >= -16{
                                        self.gxVal = "\(currentAx.rounded(toPlaces: 1))"
                                    }
                                }
                                .foregroundColor(.white)
                                .font(instntValsFontSize())
                                .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 5))
                            Text("g-y:")
                                .foregroundColor(.white)
                                .font(instntLabelsFontSize())
                                .underline()
                            Text(gyVal)
                                .onReceive(timerInstntVals) { _ in
                                    if currentAy > 16 || currentAy < -16{
                                        self.gyVal = "err"
                                    }
                                    if currentAy <= 16 && currentAy >= -16{
                                        self.gyVal = "\(currentAy.rounded(toPlaces: 1))"
                                    }
                                }
                                .foregroundColor(.white)
                                .font(instntValsFontSize())
                                .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 5))
                            Text("g-z:")
                                .foregroundColor(.white)
                                .font(instntLabelsFontSize())
                                .underline()
                            Text(gzVal)
                                .onReceive(timerInstntVals) { _ in
                                    if currentAz > 16 || currentAz < -16{
                                        self.gzVal = "err"
                                    }
                                    if currentAz <= 16 && currentAz >= -16{
                                        self.gzVal = "\(currentAz.rounded(toPlaces: 1))"
                                    }
                                }
                                .foregroundColor(.white)
                                .font(instntValsFontSize())
                        }
                        HStack{
                            Button(action: {
                                print("Export Button Pressed")
                                //self.showingCSVExport = true
                                CreateCSV()
                            }) {
                                Text("Export to CSV")
                                    .foregroundColor(Color.white)
                                    .font(Btn1FontSize())
                                    .padding(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5))
                            }.background(RoundedRectangle(cornerRadius: .infinity, style: .continuous)
                                            .stroke(Color.white, lineWidth: 3.0))

                            Button(action: {
                                print("Clear DB Button Pressed")
                                self.showingClearDBAlert = true
                            }) {
                                Text("Clear DB")
                                    .foregroundColor(Color.white)
                                    .font(Btn1FontSize())
                                    .padding(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5))
                            }.alert(isPresented: $showingClearDBAlert, content: {
                                Alert(title: Text("Database Managment"), message: Text("Are you sure you want to delete ALL Data within the Database?"), primaryButton: .destructive(Text("Yes"), action: {clearDatabase()}), secondaryButton: .cancel())
                            }).background(RoundedRectangle(cornerRadius: .infinity, style: .continuous)
                                                    .stroke(Color.white, lineWidth: 3.0))

                            Button(action: {
                                print("LFG Button Pressed")

                                self.showingLFG = true


                            }) {
                                Image("ecg")
                                    .resizable()
                                    .frame(width: 60, height: 30)
                                    .colorInvert()
                                    .padding(EdgeInsets(top: 2, leading: 4, bottom: 2, trailing: 4))
                                    .overlay(RoundedRectangle(cornerRadius: .infinity, style: .continuous)
                                                .stroke(Color.white, lineWidth: 3.0))
                            }
                        }
                        .sheet(isPresented: $showingLFG, content: {
                            if UIDevice.current.orientation == UIDeviceOrientation.landscapeLeft{
                                LFG()
                            }
                            if UIDevice.current.orientation == UIDeviceOrientation.portrait{
                                LFG().rotationEffect(Angle(degrees: 90))
                            }
                        })

                        Button(action: {
                            print("Connect Button Pressed")

                            if ConnectBtnState == 1 {
                                self.showingConnectAlert = true
                            }
                            if ConnectBtnState == 3{
                                bluetooth.disconnectPeripheral()
                                ConnectBtnState = 1
                            }

                        }) {
                            if ConnectBtnState == 1{
                                Text("Connect to Device")
                                    .foregroundColor(Color.white)
                                    .frame(width: screenSize.width*0.8, height: 40)
                                    .font(Btn1FontSize())
                                    .background(RoundedRectangle(cornerRadius: .infinity, style: .continuous).stroke(Color.white, lineWidth: 3.0))
                                    .padding(EdgeInsets(top: 5, leading: 3, bottom: 10, trailing: 3))
                            }
                            if ConnectBtnState == 2{
                                RoundedRectangle(cornerRadius: .infinity, style: .continuous)
                                    .foregroundColor(.white)
                                    .frame(width: screenSize.width*0.8, height: 40)
                                    .background(LinearGradient(gradient: orangeGradient, startPoint: .topLeading, endPoint: .bottomTrailing).mask(Text("Connecting...").font(Btn1FontSize()).scaledToFit()))
                            }
                            if ConnectBtnState == 3{
                                RoundedRectangle(cornerRadius: .infinity, style: .continuous)
                                    .frame(width: screenSize.width*0.8, height: 40)
                                    .foregroundColor(.white)
                                    .overlay(LinearGradient(gradient: orangeGradient, startPoint: .topLeading, endPoint: .bottomTrailing).mask(Text("Disconnect").font(Btn1FontSize()).scaledToFit()))
                                    .padding(EdgeInsets(top: 5, leading: 3, bottom: 10, trailing: 3))
                                    
                            }
                        }
                        .alert(isPresented: $showingConnectAlert, content: {
                            Alert(title: Text("Database Managment"), message: Text("Connecting to a new Device will Delete all Pre-Exisiting data. Do you want to Continue?"), primaryButton: .destructive(Text("Yes"), action: {self.showingBLEPicker = true
                                clearDatabase()
                            }), secondaryButton: .cancel({ConnectBtnState = 1}))
                        })
                    }.background(Rectangle()
                                    .fill(LinearGradient(gradient: orangeGradient, startPoint: .topLeading, endPoint: .bottomTrailing))
                                    .cornerRadius(20)
                                    .frame(width: screenSize.width)
                                    )
                    VStack{
                       ZStack{
                           LineView(data: TopGraphData, title: TopGraphTitle, style: selectedGraphStyle)
                               .frame(width: screenSize.width*0.9, height: screenSize.height/3, alignment: .center)
                               .onReceive( topGraphTimer, perform: {_ in self.TopGraphData = GraphDataUpdater(selector: topGraphDataSelector)
                                   selectedGraphStyle = graphStyles[self.GraphStyleSelected]
                               })
                            HStack{
                                Button(action: {
                                    print("Sp02")
                                    self.Tb1 = true
                                    self.Tb2 = false
                                    self.Tb3 = false
                                    self.Tb4 = false
                                    self.Tb5 = false
                                    self.Tb6 = false
                                    self.TopGraphTitle = "Sp02"
                                    topGraphDataSelector = 1
                                    
                                }) {
                                    if self.Tb1 == true {
                                    //case true:
                                        RoundedRectangle(cornerRadius: .infinity, style: .continuous)
                                            .foregroundColor(.white)
                                            .frame(width: screenSize.width*0.1, height: 20)
                                            .overlay(Color(color1CD8D2).mask(Text("Sp02").font(Btn2FontSize()).scaledToFit()))
                                            .padding(EdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2))
                                            .overlay(RoundedRectangle(cornerRadius: .infinity, style: .continuous)
                                                        .stroke(Color.white, lineWidth: 2.0))
                                    }
                                    if self.Tb1 == false {
                                    //case false:
                                        Text("Sp02")
                                            .foregroundColor(Color.white)
                                            .frame(width: screenSize.width*0.1, height: 20)
                                            .font(Btn2FontSize())
                                            .padding(EdgeInsets(top: 2, leading: 3, bottom: 2, trailing: 3))
                                            .overlay(RoundedRectangle(cornerRadius: .infinity, style: .continuous)
                                                        .stroke(Color.white, lineWidth: 2.0))
                                    }
                                }
                                Button(action: {
                                    print("PPG")
                                    self.Tb1 = false
                                    self.Tb2 = true
                                    self.Tb3 = false
                                    self.Tb4 = false
                                    self.Tb5 = false
                                    self.Tb6 = false
                                    self.TopGraphTitle = "PPG"
                                    topGraphDataSelector = 2
 
                                }) {
                                    if self.Tb2 == true{
                                    //case true:
                                        RoundedRectangle(cornerRadius: .infinity, style: .continuous)
                                            .foregroundColor(.white)
                                            .frame(width: screenSize.width*0.1, height: 20)
                                            .overlay(Color(color1CD8D2).mask(Text("PPG").font(Btn2FontSize()).scaledToFit()))
                                            .padding(EdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2))
                                            .overlay(RoundedRectangle(cornerRadius: .infinity, style: .continuous)
                                                        .stroke(Color.white, lineWidth: 2.0))
                                    }
                                    if self.Tb2 == false{
                                    //case false:
                                        Text("PPG")
                                            .foregroundColor(Color.white)
                                            .frame(width: screenSize.width*0.1, height: 20)
                                            .font(Btn2FontSize())
                                            .padding(EdgeInsets(top: 2, leading: 3, bottom: 2, trailing: 3))
                                            .overlay(RoundedRectangle(cornerRadius: .infinity, style: .continuous)
                                                        .stroke(Color.white, lineWidth: 2.0))
                                    }
                                }
                                Button(action: {
                                    print("BPM")
                                    self.TopGraphTitle = "BPM"
                                    self.Tb1 = false
                                    self.Tb2 = false
                                    self.Tb3 = true
                                    self.Tb4 = false
                                    self.Tb5 = false
                                    self.Tb6 = false
                                    topGraphDataSelector = 3
                                    
                                }) {
                                    if self.Tb3 == true{
                                    //case true:
                                        RoundedRectangle(cornerRadius: .infinity, style: .continuous)
                                            .foregroundColor(.white)
                                            .frame(width: screenSize.width*0.1, height: 20)
                                            .overlay(Color(color1CD8D2).mask(Text("BPM").font(Btn2FontSize()).scaledToFit()))
                                            .padding(EdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2))
                                            .overlay(RoundedRectangle(cornerRadius: .infinity, style: .continuous)
                                                        .stroke(Color.white, lineWidth: 2.0))
                                    }
                                    if self.Tb3 == false {
                                    //case false:
                                        Text("BPM")
                                            .foregroundColor(Color.white)
                                            .frame(width: screenSize.width*0.1, height: 20)
                                            .font(Btn2FontSize())
                                            .padding(EdgeInsets(top: 2, leading: 3, bottom: 2, trailing: 3))
                                            .overlay(RoundedRectangle(cornerRadius: .infinity, style: .continuous)
                                                        .stroke(Color.white, lineWidth: 2.0))
                                    }
                                }
                                Button(action: {
                                    print("g-x")
                                    self.TopGraphTitle = "g-x"
                                    self.Tb1 = false
                                    self.Tb2 = false
                                    self.Tb3 = false
                                    self.Tb4 = true
                                    self.Tb5 = false
                                    self.Tb6 = false
                                    topGraphDataSelector = 4
                                }) {
                                    if self.Tb4 == true{
                                    //case true:
                                        RoundedRectangle(cornerRadius: .infinity, style: .continuous)
                                            .foregroundColor(.white)
                                            .frame(width: screenSize.width*0.07, height: 20)
                                            .overlay(Color(color1CD8D2).mask(Text("g-x").font(Btn2FontSize()).scaledToFit()))
                                            .padding(EdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2))
                                            .overlay(RoundedRectangle(cornerRadius: .infinity, style: .continuous)
                                                        .stroke(Color.white, lineWidth: 2.0))
                                    }
                                    if self.Tb4 == false {
                                    //case false:
                                        Text("g-x")
                                            .foregroundColor(Color.white)
                                            .frame(width: screenSize.width*0.07, height: 20)
                                            .font(Btn2FontSize())
                                            .padding(EdgeInsets(top: 2, leading: 3, bottom: 2, trailing: 3))
                                            .overlay(RoundedRectangle(cornerRadius: .infinity, style: .continuous)
                                                        .stroke(Color.white, lineWidth: 2.0))
                                    }
                                }
                                Button(action: {
                                    print("g-y")
                                    self.TopGraphTitle = "g-y"
                                    self.Tb1 = false
                                    self.Tb2 = false
                                    self.Tb3 = false
                                    self.Tb4 = false
                                    self.Tb5 = true
                                    self.Tb6 = false
                                    topGraphDataSelector = 5
                                }) {
                                    if self.Tb5 == true{
                                    //case true:
                                        RoundedRectangle(cornerRadius: .infinity, style: .continuous)
                                            .foregroundColor(.white)
                                            .frame(width: screenSize.width*0.07, height: 20)
                                            .overlay(Color(color1CD8D2).mask(Text("g-y").font(Btn2FontSize()).scaledToFit()))
                                            .padding(EdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2))
                                            .overlay(RoundedRectangle(cornerRadius: .infinity, style: .continuous)
                                                        .stroke(Color.white, lineWidth: 2.0))
                                    }
                                    if self.Tb5 == false {
                                    //case false:
                                        Text("g-y")
                                            .foregroundColor(Color.white)
                                            .frame(width: screenSize.width*0.07, height: 20)
                                            .font(Btn2FontSize())
                                            .padding(EdgeInsets(top: 2, leading: 3, bottom: 2, trailing: 3))
                                            .overlay(RoundedRectangle(cornerRadius: .infinity, style: .continuous)
                                                        .stroke(Color.white, lineWidth: 2.0))
                                    }
                                }
                                Button(action: {
                                    print("g-z")
                                    self.TopGraphTitle = "g-z"
                                    self.Tb1 = false
                                    self.Tb2 = false
                                    self.Tb3 = false
                                    self.Tb4 = false
                                    self.Tb5 = false
                                    self.Tb6 = true
                                    topGraphDataSelector = 6
                                    
                                }) {
                                    if self.Tb6 == true{
                                    //case true:
                                        RoundedRectangle(cornerRadius: .infinity, style: .continuous)
                                            .foregroundColor(.white)
                                            .frame(width: screenSize.width*0.07, height: 20)
                                            .overlay(Color(color1CD8D2).mask(Text("g-z").font(Btn2FontSize()).scaledToFit()))
                                            .padding(EdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2))
                                            .overlay(RoundedRectangle(cornerRadius: .infinity, style: .continuous)
                                                        .stroke(Color.white, lineWidth: 2.0))
                                    }
                                    if self.Tb6 == false {
                                    //case false:
                                        Text("g-z")
                                            .foregroundColor(Color.white)
                                            .frame(width: screenSize.width*0.07, height: 20)
                                            .font(Btn2FontSize())
                                            .padding(EdgeInsets(top: 2, leading: 3, bottom: 2, trailing: 3))
                                            .overlay(RoundedRectangle(cornerRadius: .infinity, style: .continuous)
                                                        .stroke(Color.white, lineWidth: 2.0))
                                    }
                                }
                            }
                            .frame(width: screenSize.width*0.9, height: screenSize.height/3.7, alignment: .topTrailing)
                        }
                       ZStack{
                        LineView(data: BotGraphData, title: BotGraphTitle, style: selectedGraphStyle)
                            .frame(width: screenSize.width*0.9, height: screenSize.height/3, alignment: .center)
                            .onReceive( botGraphTimer, perform: {_ in self.BotGraphData = GraphDataUpdater(selector: botGraphDataSelector)
                                selectedGraphStyle = graphStyles[self.GraphStyleSelected]
                            })
                        HStack{
                            Button(action: {
                                print("Sp02")
                                self.Bb1 = true
                                self.Bb2 = false
                                self.Bb3 = false
                                self.Bb4 = false
                                self.Bb5 = false
                                self.Bb6 = false
                                self.BotGraphTitle = "Sp02"
                                botGraphDataSelector = 1
                                
                            }) {
                                if self.Bb1 == true{
                                //case true:
                                    RoundedRectangle(cornerRadius: .infinity, style: .continuous)
                                        .foregroundColor(.white)
                                        .frame(width: screenSize.width*0.1, height: 20)
                                        .overlay(Color(color1CD8D2).mask(Text("Sp02").font(Btn2FontSize()).scaledToFit()))
                                        .padding(EdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2))
                                        .overlay(RoundedRectangle(cornerRadius: .infinity, style: .continuous)
                                                    .stroke(Color.white, lineWidth: 2.0))
                                }
                                if self.Bb1 == false {
                                //case false:
                                    Text("Sp02")
                                        .foregroundColor(Color.white)
                                        .frame(width: screenSize.width*0.1, height: 20)
                                        .font(Btn2FontSize())
                                        .padding(EdgeInsets(top: 2, leading: 3, bottom: 2, trailing: 3))
                                        .overlay(RoundedRectangle(cornerRadius: .infinity, style: .continuous)
                                                    .stroke(Color.white, lineWidth: 2.0))
                                }
                            }
                            Button(action: {
                                print("PPG")
                                self.Bb1 = false
                                self.Bb2 = true
                                self.Bb3 = false
                                self.Bb4 = false
                                self.Bb5 = false
                                self.Bb6 = false
                                self.BotGraphTitle = "PPG"
                                botGraphDataSelector = 2
                                
                                
                            }) {
                                if self.Bb2 == true{
                                //case true:
                                    RoundedRectangle(cornerRadius: .infinity, style: .continuous)
                                        .foregroundColor(.white)
                                        .frame(width: screenSize.width*0.1, height: 20)
                                        .overlay(Color(color1CD8D2).mask(Text("PPG").font(Btn2FontSize()).scaledToFit()))
                                        .padding(EdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2))
                                        .overlay(RoundedRectangle(cornerRadius: .infinity, style: .continuous)
                                                    .stroke(Color.white, lineWidth: 2.0))
                                }
                                if self.Bb2 == false {
                                //case false:
                                    Text("PPG")
                                        .foregroundColor(Color.white)
                                        .frame(width: screenSize.width*0.1, height: 20)
                                        .font(Btn2FontSize())
                                        .padding(EdgeInsets(top: 2, leading: 3, bottom: 2, trailing: 3))
                                        .overlay(RoundedRectangle(cornerRadius: .infinity, style: .continuous)
                                                    .stroke(Color.white, lineWidth: 2.0))
                                }
                            }
                            Button(action: {
                                print("BPM")
                                self.BotGraphTitle = "BPM"
                                self.Bb1 = false
                                self.Bb2 = false
                                self.Bb3 = true
                                self.Bb4 = false
                                self.Bb5 = false
                                self.Bb6 = false
                                botGraphDataSelector = 3
                                
                            }) {
                                if self.Bb3 == true{
                                //case true:
                                    RoundedRectangle(cornerRadius: .infinity, style: .continuous)
                                        .foregroundColor(.white)
                                        .frame(width: screenSize.width*0.1, height: 20)
                                        .overlay(Color(color1CD8D2).mask(Text("BPM").font(Btn2FontSize()).scaledToFit()))
                                        .padding(EdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2))
                                        .overlay(RoundedRectangle(cornerRadius: .infinity, style: .continuous)
                                                    .stroke(Color.white, lineWidth: 2.0))
                                }
                                if self.Bb3 == false {
                                //case false:
                                    Text("BPM")
                                        .foregroundColor(Color.white)
                                        .frame(width: screenSize.width*0.1, height: 20)
                                        .font(Btn2FontSize())
                                        .padding(EdgeInsets(top: 2, leading: 3, bottom: 2, trailing: 3))
                                        .overlay(RoundedRectangle(cornerRadius: .infinity, style: .continuous)
                                                    .stroke(Color.white, lineWidth: 2.0))
                                }
                            }
                            Button(action: {
                                print("g-x")
                                self.BotGraphTitle = "g-x"
                                self.Bb1 = false
                                self.Bb2 = false
                                self.Bb3 = false
                                self.Bb4 = true
                                self.Bb5 = false
                                self.Bb6 = false
                                botGraphDataSelector = 4
                            }) {
                                if self.Bb4 == true{
                                //case true:
                                    RoundedRectangle(cornerRadius: .infinity, style: .continuous)
                                        .foregroundColor(.white)
                                        .frame(width: screenSize.width*0.07, height: 20)
                                        .overlay(Color(color1CD8D2).mask(Text("g-x").font(Btn2FontSize()).scaledToFit()))
                                        .padding(EdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2))
                                        .overlay(RoundedRectangle(cornerRadius: .infinity, style: .continuous)
                                                    .stroke(Color.white, lineWidth: 2.0))
                                }
                                if self.Bb4 == false {
                                //case false:
                                    Text("g-x")
                                        .foregroundColor(Color.white)
                                        .frame(width: screenSize.width*0.07, height: 20)
                                        .font(Btn2FontSize())
                                        .padding(EdgeInsets(top: 2, leading: 3, bottom: 2, trailing: 3))
                                        .overlay(RoundedRectangle(cornerRadius: .infinity, style: .continuous)
                                                    .stroke(Color.white, lineWidth: 2.0))
                                }
                            }
                            Button(action: {
                                print("g-y")
                                self.BotGraphTitle = "g-y"
                                self.Bb1 = false
                                self.Bb2 = false
                                self.Bb3 = false
                                self.Bb4 = false
                                self.Bb5 = true
                                self.Bb6 = false
                                botGraphDataSelector = 5
                            }) {
                                if self.Bb5 == true{
                                //case true:
                                    RoundedRectangle(cornerRadius: .infinity, style: .continuous)
                                        .foregroundColor(.white)
                                        .frame(width: screenSize.width*0.07, height: 20)
                                        .overlay(Color(color1CD8D2).mask(Text("g-y").font(Btn2FontSize()).scaledToFit()))
                                        .padding(EdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2))
                                        .overlay(RoundedRectangle(cornerRadius: .infinity, style: .continuous)
                                                    .stroke(Color.white, lineWidth: 2.0))
                                }
                                if self.Bb5 == false {
                                //case false:
                                    Text("g-y")
                                        .foregroundColor(Color.white)
                                        .frame(width: screenSize.width*0.07, height: 20)
                                        .font(Btn2FontSize())
                                        .padding(EdgeInsets(top: 2, leading: 3, bottom: 2, trailing: 3))
                                        .overlay(RoundedRectangle(cornerRadius: .infinity, style: .continuous)
                                                    .stroke(Color.white, lineWidth: 2.0))
                                }
                            }
                            Button(action: {
                                print("g-z")
                                self.BotGraphTitle = "g-z"
                                self.Bb1 = false
                                self.Bb2 = false
                                self.Bb3 = false
                                self.Bb4 = false
                                self.Bb5 = false
                                self.Bb6 = true
                                botGraphDataSelector = 6
                                
                            }) {
                                if self.Bb6 == true {
                                //case true:
                                    RoundedRectangle(cornerRadius: .infinity, style: .continuous)
                                        .foregroundColor(.white)
                                        .frame(width: screenSize.width*0.07, height: 20)
                                        .overlay(Color(color1CD8D2).mask(Text("g-z").font(Btn2FontSize()).scaledToFit()))
                                        .padding(EdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2))
                                        .overlay(RoundedRectangle(cornerRadius: .infinity, style: .continuous)
                                                    .stroke(Color.white, lineWidth: 2.0))
                                }
                                if self.Bb6 == false {
                                //case false:
                                    Text("g-z")
                                        .foregroundColor(Color.white)
                                        .frame(width: screenSize.width*0.07, height: 20)
                                        .font(Btn2FontSize())
                                        .padding(EdgeInsets(top: 2, leading: 3, bottom: 2, trailing: 3))
                                        .overlay(RoundedRectangle(cornerRadius: .infinity, style: .continuous)
                                                    .stroke(Color.white, lineWidth: 2.0))
                                }
                            }
                        }
                        .frame(width: screenSize.width*0.9, height: screenSize.height/3.7, alignment: .topTrailing)
                        
                    }
                    }
                    .padding(EdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8))
                    .frame(width: screenSize.width)
                    .background(Rectangle()
                                    .fill(LinearGradient(gradient: blueGradient, startPoint: .topLeading, endPoint: .bottomTrailing))
                                    .cornerRadius(20))
                
//              New stack at the bottom for EKG.
                VStack{
                        LineView(data: EKGGraphData, title: EKGGraphTitle, style: selectedGraphStyle)
                        .frame(width: screenSize.width*0.9, height: screenSize.height/3, alignment: .center)
                            .onReceive( EKGGraphTimer, perform: {_ in self.EKGGraphData = heartRatePPG
                                selectedGraphStyle = graphStyles[self.GraphStyleSelected]
                            })
                }.background(Rectangle()
                            .fill(LinearGradient(gradient: orangeGradient, startPoint: .topLeading, endPoint: .bottomTrailing))
                            .cornerRadius(20)
                            .frame(width: screenSize.width))
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
                    
                }.frame(width: 300, height: 200)
                .cornerRadius(20)
                .position(x: screenSize.width * 0.5, y: 300)
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
                .frame(width: 300, height: 200)
                .cornerRadius(20)
                .position(x: screenSize.width * 0.5, y: 300)
                .shadow(radius: 6)
            }
        }
    }
        }
    }


struct HomeUIView_Previews: PreviewProvider {
    static var previews: some View {
        HomeUIView()
    }
}

struct Arc: InsettableShape{
    var startAngle: Angle
    var endAngle: Angle
    var clockWise: Bool
    var insetAmount: CGFloat = 0
    
    func inset(by amount: CGFloat) -> some InsettableShape {
        var arc = self
        arc.insetAmount += amount
        return arc
    }
    
    func path(in rect: CGRect) -> Path {
        let rotationAdjustment = Angle.degrees(-90)
        let modifiedStart = startAngle - rotationAdjustment
        let modifiedEnd = endAngle - rotationAdjustment
        
        var path = Path()
        path.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: rect.width/2, startAngle: modifiedStart, endAngle: modifiedEnd, clockwise: clockWise)
        
        
        return path
    }
    
}

func InstateProgressTimer(){
    
}

func GraphDataUpdater(selector: Int) -> Array<Double>{
    switch selector {
    case 1:
        return sp02Data
    case 2:
        return heartRatePPG
    case 3:
        return heartRateBPM
    case 4:
        return accelXData
    case 5:
        return accelYData
    case 6:
        return accelZData
    default:
        return Array()
    }
}

func MultiGraphDataUpdater(selector: Int) -> Array<([Double],GradientColor)>{
    switch selector {
    case 1:
        return [(heartRatePPG,blackG),(PPGreddata,blueG)]
    default:
        return Array()
    }
}

func instntLabelsFontSize() -> Font{
    var selectedFont = UIFont()
    if screenSize.height < 700 {
        selectedFont = UIFont(name: "Helvetica", size: 26)!
        
    }
    if screenSize.height > 700.0 && screenSize.height < 800.0{
        selectedFont = UIFont(name: "Helvetica", size: 28)!
       
    }
    if screenSize.height > 800 {
        selectedFont = UIFont(name: "Helvetica", size: 30)!
        
    }
    return Font(selectedFont)
}

func instntValsFontSize() -> Font{
    var selectedFont = UIFont()
    if screenSize.height < 700 {
        selectedFont = UIFont(name: "Helvetica", size: 21)!
        
    }
    if screenSize.height > 700.0 && screenSize.height < 800.0{
        selectedFont = UIFont(name: "Helvetica", size: 24)!
       
    }
    if screenSize.height > 800 {
        selectedFont = UIFont(name: "Helvetica", size: 25)!
        
    }
    return Font(selectedFont)
}
func instntValsFontSize2() -> Font{
    var selectedFont = UIFont()
    if screenSize.height < 700 {
        selectedFont = UIFont(name: "Helvetica", size: 24)!
        
    }
    if screenSize.height > 700.0 && screenSize.height < 800.0{
        selectedFont = UIFont(name: "Helvetica", size: 27)!
       
    }
    if screenSize.height > 800 {
        selectedFont = UIFont(name: "Helvetica", size: 28)!
        
    }
    return Font(selectedFont)
}

func Btn1FontSize() -> Font{
    var selectedFont = UIFont()
    if screenSize.height < 700 {
        selectedFont = UIFont(name: "Helvetica", size: 21)!
        
    }
    if screenSize.height > 700.0 && screenSize.height < 800.0{
        selectedFont = UIFont(name: "Helvetica", size: 24)!
       
    }
    if screenSize.height > 800 {
        selectedFont = UIFont(name: "Helvetica", size: 25)!
        
    }
    return Font(selectedFont)
}
func Btn2FontSize() -> Font{
    var selectedFont = UIFont()
    if screenSize.height < 700 {
        selectedFont = UIFont(name: "Helvetica", size: 12)!
        
    }
    if screenSize.height > 700.0 && screenSize.height < 800.0{
        selectedFont = UIFont(name: "Helvetica", size: 12)!
       
    }
    if screenSize.height > 800 {
        selectedFont = UIFont(name: "Helvetica", size: 12)!
        
    }
    return Font(selectedFont)
}

func Btn3FontSize() -> Font{
    var selectedFont = UIFont()
    if screenSize.height < 700 {
        selectedFont = UIFont(name: "Helvetica", size: 16)!
        
    }
    if screenSize.height > 700.0 && screenSize.height < 800.0{
        selectedFont = UIFont(name: "Helvetica", size: 16)!
       
    }
    if screenSize.height > 800 {
        selectedFont = UIFont(name: "Helvetica", size: 16)!
        
    }
    return Font(selectedFont)
}




let orangeGradient = Gradient(colors: [Color(colorF27094C),Color(colorFF9472)])
let blueGradient = Gradient(colors: [Color(color1CD8D2),Color(color7474BF)])

//MARK: CSV Generation
func CreateCSV(){

    var csvString = "\("CodeCompileDate: ")\(CodeCompileDate)\n\n\("CodeCompileName: ")\(CodeCompileName)\n\n\("SDSaveName: ")\(SDSaveName)\n\n\("IphoneTime"),\("ePoDTime"),\("Sp02"),\("BPM"),\("PPG_IR"),\("Grav_X"),\("Grav_Y"),\("Grav_Z"),\("R_Ratio_Red"),\("Note"),\("Temperature"),\("PPG_Red"),\("BPM_Red"),\("SP02_Red"),\("BPM_Green"),\("SP02_Green"),\("R_Ratio_Green"),\("DC_Bias_Red"),\("DC_Bias_Green"),\("EKG")\n\n"

    for i in 0..<DeviceTime.count-1{
        csvString = csvString.appending("\(DeviceTime[i]),\(ePodTime[i]),\(String(database[0][i])),\(String(database[1][i])),\(String(database[2][i])),\(String(database[3][i])),\(String(database[4][i])),\(String(database[5][i])),\(String(database[6][i])),\(String(database[7][i])),\(String(database[8][i])),\(String(database[9][i])),\(String(database2[0][i])),\(String(database2[1][i])),\(String(database2[2][i])),\(String(database2[3][i])),\(String(database2[4][i])),\(String(database2[5][i])),\(String(database2[6][i])),\(String(database[3][i]))\n")
    }

    let fileManager = FileManager.default
    let fileURL: URL
    
    let date = Date()
    let df = DateFormatter()
    var t = String()
    
    if utcFormat == true{
        df.dateFormat = "yyyy_MM_dd HH_mm_ss"
        df.timeZone = NSTimeZone(abbreviation: "UTC") as TimeZone?
        t = df.string(from: date) + "_UTC"
    }
    if utcFormat == false{
        df.dateFormat = "yyyy_MM_dd HH_mm_ss"
        t = df.string(from: date) + "_" + TimeZone.current.abbreviation()!
    }
    
    
    do {
        let filename = "ePoD_ReportGenerated_\(t).csv"
        
        let path = try fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        fileURL = path.appendingPathComponent(filename)
        
        try csvString.write(to: fileURL, atomically: true, encoding: .utf8)
        //return fileURL
        let objectsToShare = [fileURL]
        let vc = UIActivityViewController(activityItems: objectsToShare as [Any], applicationActivities: [])
        
        // else for IPADS and if for iphones
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.phone) {
            UIApplication.shared.windows.first?.rootViewController?.present(vc, animated: true, completion: nil)
        }
        else{
            let activityViewController = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)

            if let popoverController = activityViewController.popoverPresentationController {
                popoverController.sourceRect = CGRect(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 2, width: 0, height: 0)
                popoverController.sourceView = UIApplication.shared.windows.first?.rootViewController?.view
                popoverController.permittedArrowDirections = UIPopoverArrowDirection(rawValue: 0)
            }
            UIApplication.shared.windows.first?.rootViewController?.present(activityViewController, animated: true, completion: nil)
        }
        
    }
    catch {
        print("Error Creating File")
        //return nil
}

}


func clearDatabase(){
    database = [[""],[""],[""],[""],[""],[""],[""],[""],[""],[""]] // Devicetime|Sp02|PPG|BPM|AX|AY|AZ|R_VAL|BEATRESET|TEMP
    DeviceTime = [""]
    ePodTime = [""]
    sp02Data = Array(repeating: Double(0), count: 200)
    heartRatePPG = Array(repeating: Double(0), count: 200)
    heartRateBPM = Array(repeating: Double(0), count: 600)
    accelXData = Array(repeating: Double(0), count: 600)
    accelYData = Array(repeating: Double(0), count: 600)
    accelZData = Array(repeating: Double(0), count: 600)
    
    currentAx = 0.0
    currentAy = 0.0
    currentAz = 0.0
    currentBPM = 0.0
    currentSp02 = 0.0
}
