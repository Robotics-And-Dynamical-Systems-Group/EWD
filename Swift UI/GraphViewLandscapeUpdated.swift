//
//  GraphViewLandscapeUpdated.swift
//  ePoD
//
//  Created by epod on 4/24/21.
//  Copyright © 2021 Tyler Goudie. All rights reserved.
//

import SwiftUI
import SwiftUICharts

struct GraphViewLandscapeUpdated: View {
    
    @State var GraphData = heartRatePPG
    @State var GraphDataMulti = [(heartRatePPG,blackG),(PPGreddata,blueG)]
    @State var GraphTitle = "PPG"
    @State var b1 = false
    @State var b2 = true
    @State var b3 = false
    @State var b4 = false
    @State var b5 = false
    @State var b6 = false
    @State var b7 = false
    @State var multiLine = false
    let LFGTimer = Timer.publish(every: 0.05, on: .main, in: .common).autoconnect()
    
    
    var body: some View {
        
        ZStack{
            Rectangle()
            .fill(LinearGradient(gradient: blueGradient, startPoint: .topLeading, endPoint: .bottomTrailing)).cornerRadius(20.0)
                
            
            HStack{
                HStack{ // Spacer
                    Rectangle()
                        .fill(Color.clear).cornerRadius(20.0)
                    Rectangle()
                        .fill(Color.clear).cornerRadius(20.0)
                        
                        
                    VStack{ // Button Stack
                        ZStack{
                            Button(action: {
                                print("Sp02")
                                self.b1 = true
                                self.b2 = false
                                self.b3 = false
                                self.b4 = false
                                self.b5 = false
                                self.b6 = false
                                self.b7 = false
                                self.GraphTitle = "Sp02"
                                GraphDataSelector = 1
                                
                            }) {
                                switch self.b1{
                                case true:
                                    RoundedRectangle(cornerRadius: .infinity, style: .continuous)
                                        .foregroundColor(.white)
                                        .frame(width: screenSize.width*0.175, height: 30)
                                        .overlay(Color(color1CD8D2).mask(Text("Sp02").font(.title2).scaledToFit()))
                                        .padding(EdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2))
                                        .overlay(RoundedRectangle(cornerRadius: .infinity, style: .continuous)
                                                    .stroke(Color.white, lineWidth: 2.0))
                                        
                                case false:
                                    Text("Sp02")
                                        .foregroundColor(Color.white)
                                       
                                        .frame(width: screenSize.width*0.175, height: 30)
                                        .font(.title2)
                                        
                                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                                        .overlay(RoundedRectangle(cornerRadius: .infinity, style: .continuous)
                                                    .stroke(Color.white, lineWidth: 2.0))
                                }
                            }
                        }.padding(.all,21)
                        .rotationEffect(.degrees(90))
                        
                        ZStack{
                            Button(action: {
                                print("PPG")
                                self.b1 = false
                                self.b2 = true
                                self.b3 = false
                                self.b4 = false
                                self.b5 = false
                                self.b6 = false
                                self.b7 = false
                                self.GraphTitle = "PPG"
                                GraphDataSelector = 2
                                multiLine = false
                                
                            }) {
                                switch self.b2{
                                case true:
                                    RoundedRectangle(cornerRadius: .infinity, style: .continuous)
                                        .foregroundColor(.white)
                                        .frame(width: screenSize.width*0.175, height: 30)
                                        .overlay(Color(color1CD8D2).mask(Text("PPG").font(.title2).scaledToFit()))
                                        .padding(EdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2))
                                        .overlay(RoundedRectangle(cornerRadius: .infinity, style: .continuous)
                                                    .stroke(Color.white, lineWidth: 2.0))
                                case false:
                                    Text("PPG")
                                        .foregroundColor(Color.white)
                                        .frame(width: screenSize.width*0.175, height: 30)
                                        .font(.title2)
                                        .padding(EdgeInsets(top: 2, leading: 3, bottom: 2, trailing: 3))
                                        .overlay(RoundedRectangle(cornerRadius: .infinity, style: .continuous)
                                                    .stroke(Color.white, lineWidth: 2.0))
                                }
                            }
                        }.padding(.all,21)
                        .rotationEffect(.degrees(90))
                        
                        
                        
                        ZStack{
                            Button(action: {
                                print("BPM")
                                self.GraphTitle = "BPM"
                                self.b1 = false
                                self.b2 = false
                                self.b3 = true
                                self.b4 = false
                                self.b5 = false
                                self.b6 = false
                                self.b7 = false
                                GraphDataSelector = 3
                                multiLine = false
                            }) {
                                switch self.b3{
                                case true:
                                    RoundedRectangle(cornerRadius: .infinity, style: .continuous)
                                        .foregroundColor(.white)
                                        .frame(width: screenSize.width*0.175, height: 30)
                                        .overlay(Color(color1CD8D2).mask(Text("BPM").font(.title2).scaledToFit()))
                                        .padding(EdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2))
                                        .overlay(RoundedRectangle(cornerRadius: .infinity, style: .continuous)
                                                    .stroke(Color.white, lineWidth: 2.0))
                                case false:
                                    Text("BPM")
                                        .foregroundColor(Color.white)
                                        .frame(width: screenSize.width*0.175, height: 30)
                                        .font(.title2)
                                        .padding(EdgeInsets(top: 2, leading: 3, bottom: 2, trailing: 3))
                                        .overlay(RoundedRectangle(cornerRadius: .infinity, style: .continuous)
                                                    .stroke(Color.white, lineWidth: 2.0))
                                }
                            }
                        }.padding(.all,21)
                        .rotationEffect(.degrees(90))
                        
                        
                        ZStack{
                            Button(action: {
                                print("g-x")
                                self.GraphTitle = "g-x"
                                self.b1 = false
                                self.b2 = false
                                self.b3 = false
                                self.b4 = true
                                self.b5 = false
                                self.b6 = false
                                self.b7 = false
                                GraphDataSelector = 4
                                multiLine = false
                            }) {
                                switch self.b4{
                                case true:
                                    RoundedRectangle(cornerRadius: .infinity, style: .continuous)
                                        .foregroundColor(.white)
                                        .frame(width: screenSize.width*0.175, height: 30)
                                        .overlay(Color(color1CD8D2).mask(Text("g-X").font(.title2).scaledToFit()))
                                        .padding(EdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2))
                                        .overlay(RoundedRectangle(cornerRadius: .infinity, style: .continuous)
                                                    .stroke(Color.white, lineWidth: 2.0))
                                case false:
                                    Text("g-X")
                                        .foregroundColor(Color.white)
                                        .frame(width: screenSize.width*0.175, height: 30)
                                        .font(.title2)
                                        .padding(EdgeInsets(top: 2, leading: 3, bottom: 2, trailing: 3))
                                        .overlay(RoundedRectangle(cornerRadius: .infinity, style: .continuous)
                                                    .stroke(Color.white, lineWidth: 2.0))
                                }
                            }
                        }.padding(.all,21)
                        .rotationEffect(.degrees(90))
                        
                        
                        ZStack{
                            Button(action: {
                                print("g-y")
                                self.GraphTitle = "g-y"
                                self.b1 = false
                                self.b2 = false
                                self.b3 = false
                                self.b4 = false
                                self.b5 = true
                                self.b6 = false
                                self.b7 = false
                                GraphDataSelector = 5
                                multiLine = false
                            }) {
                                switch self.b5{
                                case true:
                                    RoundedRectangle(cornerRadius: .infinity, style: .continuous)
                                        .foregroundColor(.white)
                                        .frame(width: screenSize.width*0.175, height: 30)
                                        .overlay(Color(color1CD8D2).mask(Text("g-Y").font(.title2).scaledToFit()))
                                        .padding(EdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2))
                                        .overlay(RoundedRectangle(cornerRadius: .infinity, style: .continuous)
                                                    .stroke(Color.white, lineWidth: 2.0))
                                case false:
                                    Text("g-Y")
                                        .foregroundColor(Color.white)
                                        .frame(width: screenSize.width*0.175, height: 30)
                                        .font(.title2)
                                        .padding(EdgeInsets(top: 2, leading: 3, bottom: 2, trailing: 3))
                                        .overlay(RoundedRectangle(cornerRadius: .infinity, style: .continuous)
                                                    .stroke(Color.white, lineWidth: 2.0))
                                }
                            }
                        }.padding(.all,21)
                        .rotationEffect(.degrees(90))
                        
                        
                        ZStack{
                            Button(action: {
                                print("g-z")
                                self.GraphTitle = "g-z"
                                self.b1 = false
                                self.b2 = false
                                self.b3 = false
                                self.b4 = false
                                self.b5 = false
                                self.b6 = true
                                self.b7 = false
                                GraphDataSelector = 6
                                multiLine = false
                            }) {
                                switch self.b6{
                                case true:
                                    RoundedRectangle(cornerRadius: .infinity, style: .continuous)
                                        .foregroundColor(.white)
                                        .frame(width: screenSize.width*0.175, height: 30)
                                        .overlay(Color(color1CD8D2).mask(Text("g-Z").font(.title2).scaledToFit()))
                                        .padding(EdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2))
                                        .overlay(RoundedRectangle(cornerRadius: .infinity, style: .continuous)
                                                    .stroke(Color.white, lineWidth: 2.0))
                                case false:
                                    Text("g-Z")
                                        .foregroundColor(Color.white)
                                        .frame(width: screenSize.width*0.175, height: 30)
                                        .font(.title2)
                                        .padding(EdgeInsets(top: 2, leading: 3, bottom: 2, trailing: 3))
                                        .overlay(RoundedRectangle(cornerRadius: .infinity, style: .continuous)
                                                    .stroke(Color.white, lineWidth: 2.0))
                                }
                            }
                        }.padding(.all,21)
                        .rotationEffect(.degrees(90))
                        
                        
                        ZStack{
                            Button(action: {
                                print("Multi")
                                self.GraphTitle = "Multi"
                                self.b1 = false
                                self.b2 = false
                                self.b3 = false
                                self.b4 = false
                                self.b5 = false
                                self.b6 = false
                                self.b7 = true
                                //GraphDataSelector = 6
                                multiLine = true
                            }) {
                                switch self.b7{
                                case true:
                                    RoundedRectangle(cornerRadius: .infinity, style: .continuous)
                                        .foregroundColor(.blue)
                                        .frame(width: screenSize.width*0.14, height: 30)
                                        .overlay(Color(.white).mask(Text("Multi").font(Btn3FontSize()).scaledToFit()))
                                        .padding(EdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2))
                                        .overlay(RoundedRectangle(cornerRadius: .infinity, style: .continuous)
                                                    .stroke(Color.blue, lineWidth: 5.0))
                                case false:
                                    Text("Multi")
                                        .foregroundColor(Color.white)
                                        .frame(width: screenSize.width*0.175, height: 30)
                                        .font(.title2)
                                        .padding(EdgeInsets(top: 2, leading: 3, bottom: 2, trailing: 3))
                                        .overlay(RoundedRectangle(cornerRadius: .infinity, style: .continuous)
                                                    .stroke(Color.white, lineWidth: 3.0))
                                }
                            }
                        }.padding(.all,25)
                        .rotationEffect(.degrees(90))
                        
                    }.frame(width: 80 , height: 380, alignment: .center)
                }
            }
            
            ZStack{
            if multiLine == false {
                
               LineView2(data: GraphData, title: GraphTitle, style: selectedGraphStyle )
                
                
                .frame(width: 500 , height: 300) // Must Be Same as Set in LineView2 Class
                //.position(x: screenSize.width*0.5, y: screenSize.height*0.475)
                .onReceive(LFGTimer, perform: {_ in self.GraphData = GraphDataUpdater(selector: GraphDataSelector)})
                
                    
            } else {
                MultiLineChartView(data: [(heartRatePPG,blackG),(PPGreddata,blueG)], title: GraphTitle)
                        
                        //.frame(width: 700, height: 410)
                        //.position(x: screenSize.width*0.5, y: screenSize.height*0.475)
                        .onReceive(LFGTimer, perform: {_ in self.GraphDataMulti = MultiGraphDataUpdater(selector: 1)})
                }
            }.rotationEffect(Angle(degrees: 90))
            .frame(width: 400, height: 600, alignment: .center)
        }
    }
}

struct GraphViewLandscapeUpdated_Previews: PreviewProvider {
    static var previews: some View {
        GraphViewLandscapeUpdated()
    }
}
