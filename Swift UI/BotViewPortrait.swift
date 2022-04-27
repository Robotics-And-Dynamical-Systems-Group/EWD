//
//  BotView.swift
//  ePoD
//
//  Created by epod on 3/2/21.
//  Copyright © 2021 Tyler Goudie. All rights reserved.
//

import SwiftUI
import SwiftUICharts

struct BotViewPortrait: View {
    let topGraphTimer = Timer.publish(every: 0.05, on: .main, in: .common).autoconnect()
    let botGraphTimer = Timer.publish(every: 0.05, on: .main, in: .common).autoconnect()
    
    //@State var GraphStyleSelected = 0
    @State var TopGraphData = RandomArray
    @State var TopGraphTitle = "PPG"
    @State var BotGraphData = RandomArray
    @State var BotGraphTitle = "SP02"
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
    @ObservedObject var Settings: AppState = .shared
    
    var body: some View {
        ZStack{
            //Set Background Color
            Rectangle()
                .fill(LinearGradient(gradient: blueGradient, startPoint: .topLeading, endPoint: .bottomTrailing)).cornerRadius(20.0)
            VStack{
                ZStack{
                    
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
                    }.position(x: 250, y: 23)
                    
                    LineView(data: TopGraphData, title: TopGraphTitle, style: selectedGraphStyle)
                        .frame(width: screenSize.width*0.85, height: screenSize.height*0.03)
                        .position(x: screenSize.width*0.5, y: 0)
                        .onReceive( topGraphTimer, perform: {_ in self.TopGraphData = GraphDataUpdater(selector: topGraphDataSelector)
                            
                            selectedGraphStyle = graphStyles[self.Settings.GraphSelection]
                            
                        })
                        
                        
                        
                }
                
            
                ZStack{
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
                    }.position(x: 250, y: 23)
                    
                    LineView(data: BotGraphData, title: BotGraphTitle, style: selectedGraphStyle)
                        .frame(width: screenSize.width*0.85, height: screenSize.height*0.03)
                        .position(x: screenSize.width*0.5, y: 0)
                        .onReceive( botGraphTimer, perform: {_ in self.BotGraphData = GraphDataUpdater(selector: botGraphDataSelector)
                            selectedGraphStyle = graphStyles[self.Settings.GraphSelection]
                        })
                        
                    
                        
                }
            }
        }
    }
}

struct BotView_Previews: PreviewProvider {
    static var previews: some View {
        BotViewPortrait()
    }
}
