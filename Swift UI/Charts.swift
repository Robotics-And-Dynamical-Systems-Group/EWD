//
//  Charts.swift
//  ePoD
//
//  Created by Tyler Goudie on 7/9/20.
//  Copyright © 2020 Tyler Goudie. All rights reserved.
//

import SwiftUI
import SwiftUICharts

var GraphDataSelector = 2
struct LFG: View {
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
            Color.white
                .edgesIgnoringSafeArea(.all)
            ScrollView(.horizontal){
                HStack{
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
                                .foregroundColor(.blue)
                                .frame(width: screenSize.width*0.2, height: 30)
                                .overlay(Color(.white).mask(Text("Sp02").font(Btn3FontSize()).scaledToFit()))
                                .padding(EdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2))
                                .overlay(RoundedRectangle(cornerRadius: .infinity, style: .continuous)
                                            .stroke(Color.blue, lineWidth: 5.0))
                                
                        case false:
                            Text("Sp02")
                            
                                .frame(width: screenSize.width*0.2, height: 30)
                                .foregroundColor(.black)
                                .font(Btn3FontSize())
                                .padding(EdgeInsets(top: 2, leading: 3, bottom: 2, trailing: 3))
                                .overlay(RoundedRectangle(cornerRadius: .infinity, style: .continuous)
                                            .stroke(Color.black, lineWidth: 2.0))
                        }
                    }
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
                                .foregroundColor(.blue)
                                .frame(width: screenSize.width*0.18, height: 30)
                                .overlay(Color(.white).mask(Text("PPG").font(Btn3FontSize()).scaledToFit()))
                                .padding(EdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2))
                                .overlay(RoundedRectangle(cornerRadius: .infinity, style: .continuous)
                                            .stroke(Color.blue, lineWidth: 5.0))
                        case false:
                            Text("PPG")
                                
                                .frame(width: screenSize.width*0.18, height: 30)
                                .font(Btn3FontSize())
                                .foregroundColor(.black)
                                .padding(EdgeInsets(top: 2, leading: 3, bottom: 2, trailing: 3))
                                .overlay(RoundedRectangle(cornerRadius: .infinity, style: .continuous)
                                            .stroke(Color.black, lineWidth: 2.0))
                        }
                    }
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
                                .foregroundColor(.blue)
                                .frame(width: screenSize.width*0.18, height: 30)
                                .overlay(Color(.white).mask(Text("BPM").font(Btn3FontSize()).scaledToFit()))
                                .padding(EdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2))
                                .overlay(RoundedRectangle(cornerRadius: .infinity, style: .continuous)
                                            .stroke(Color.blue, lineWidth: 5.0))
                        case false:
                            Text("BPM")
                               
                                .frame(width: screenSize.width*0.18, height: 30)
                                .foregroundColor(.black)
                                .font(Btn3FontSize())
                                .padding(EdgeInsets(top: 2, leading: 3, bottom: 2, trailing: 3))
                                .overlay(RoundedRectangle(cornerRadius: .infinity, style: .continuous)
                                            .stroke(Color.black, lineWidth: 2.0))
                        }
                    }
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
                                .foregroundColor(.blue)
                                .frame(width: screenSize.width*0.14, height: 30)
                                .overlay(Color(.white).mask(Text("g-x").font(Btn3FontSize()).scaledToFit()))
                                .padding(EdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2))
                                .overlay(RoundedRectangle(cornerRadius: .infinity, style: .continuous)
                                            .stroke(Color.blue, lineWidth: 5.0))
                        case false:
                            Text("g-x")
                                
                                .frame(width: screenSize.width*0.14, height: 30)
                                .foregroundColor(.black)
                                .font(Btn3FontSize())
                                .padding(EdgeInsets(top: 2, leading: 3, bottom: 2, trailing: 3))
                                .overlay(RoundedRectangle(cornerRadius: .infinity, style: .continuous)
                                            .stroke(Color.black, lineWidth: 2.0))
                        }
                    }
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
                                .foregroundColor(.blue)
                                .frame(width: screenSize.width*0.14, height: 30)
                                .overlay(Color(.white).mask(Text("g-y").font(Btn3FontSize()).scaledToFit()))
                                .padding(EdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2))
                                .overlay(RoundedRectangle(cornerRadius: .infinity, style: .continuous)
                                            .stroke(Color.blue, lineWidth: 5.0))
                        case false:
                            Text("g-y")
                               
                                .frame(width: screenSize.width*0.14, height: 30)
                                .foregroundColor(.black)
                                .font(Btn3FontSize())
                                .padding(EdgeInsets(top: 2, leading: 3, bottom: 2, trailing: 3))
                                .overlay(RoundedRectangle(cornerRadius: .infinity, style: .continuous)
                                            .stroke(Color.black, lineWidth: 2.0))
                        }
                    }
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
                                .foregroundColor(.blue)
                                .frame(width: screenSize.width*0.14, height: 30)
                                .overlay(Color(.white).mask(Text("g-z").font(Btn3FontSize()).scaledToFit()))
                                .padding(EdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2))
                                .overlay(RoundedRectangle(cornerRadius: .infinity, style: .continuous)
                                            .stroke(Color.blue, lineWidth: 5.0))
                        case false:
                            Text("g-z")
                                
                                .frame(width: screenSize.width*0.14, height: 30)
                                .foregroundColor(.black)
                                .font(Btn3FontSize())
                                .padding(EdgeInsets(top: 2, leading: 3, bottom: 2, trailing: 3))
                                .overlay(RoundedRectangle(cornerRadius: .infinity, style: .continuous)
                                            .stroke(Color.black, lineWidth: 2.0))
                        }
                    }
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
                                
                                .frame(width: screenSize.width*0.14, height: 30)
                                .foregroundColor(.black)
                                .font(Btn3FontSize())
                                .padding(EdgeInsets(top: 2, leading: 3, bottom: 2, trailing: 3))
                                .overlay(RoundedRectangle(cornerRadius: .infinity, style: .continuous)
                                            .stroke(Color.black, lineWidth: 2.0))
                        }
                    }
                }
                .position(x: screenSize.width*0.60, y: screenSize.minY+100)
            }
            if multiLine == false {
                
               LineViewMagnifier(data: GraphData, title: GraphTitle, style: GraphStyle2 )
//                .rotationEffect(Angle(degrees: 90))
                .frame(width: 750, height: 450)
                .position(x: screenSize.width*0.4, y: screenSize.height*0.475)
                .onReceive(LFGTimer, perform: {_ in self.GraphData = GraphDataUpdater(selector: GraphDataSelector)})
                    
            } else {
                MultiLineChartView(data: GraphDataMulti, title: GraphTitle, style: Styles.lineChartStyleOne)
                        .rotationEffect(Angle(degrees: 90))
                        .frame(width: 750, height: 450)
                        .position(x: screenSize.width*0.4, y: screenSize.height*0.475)
                        .onReceive(LFGTimer, perform: {_ in self.GraphDataMulti = MultiGraphDataUpdater(selector: 1)})
            }
            }
        }
            
    }

let blackG = GradientColor(start: .black, end: .black)
let blueG = GradientColor(start: .blue, end: .blue)

struct LFG_Previews: PreviewProvider {
    static var previews: some View {
        LFG()
    }
}

