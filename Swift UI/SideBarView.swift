//
//  SideBarView.swift
//  ePoD
//
//  Created by epod on 4/25/21.
//  Copyright © 2021 Tyler Goudie. All rights reserved.
//

import SwiftUI

struct SideBarView: View {
    
    let timer = Timer.publish(every: 0.25, on: .main, in: .common).autoconnect()
    
    @State var gxVal = String()
    @State var gyVal = String()
    @State var gzVal = String()
    @State var sp02Val = String()
    @State var bpmVal = String()
    @State var tempVal = String()
    @State var tempSelection = ["F°","C°","K°"]
    //@State var tempSelected = 0
    @ObservedObject var Settings: AppState = .shared
    
    var body: some View {
        ZStack{
            // Set Background Color
            Rectangle()
                .fill(LinearGradient(gradient: orangeGradient, startPoint: .topLeading, endPoint: .bottomTrailing)).cornerRadius(20.0)
            VStack{
                HStack{
                    Text("g-z:")
                        .foregroundColor(.white)
                        .font(.title)
                        .underline()
                        .rotationEffect(.degrees(90))
                        .frame(width: 50, height: 100)
                    
                    Text("g-y:")
                        .foregroundColor(.white)
                        .font(.title)
                        .underline()
                        .rotationEffect(.degrees(90))
                        .frame(width: 50, height: 100)
                    
                    Text("g-x:")
                        .foregroundColor(.white)
                        .font(.title)
                        .underline()
                        .rotationEffect(.degrees(90))
                        .frame(width: 50, height: 100)
                    
                    Text("\(tempSelection[self.Settings.TempSelected]):")
                        .foregroundColor(.white)
                        .font(.title)
                        .underline()
                        .rotationEffect(.degrees(90))
                        .frame(width: 50, height: 100)
                    
                    Text("BPM:")
                        .foregroundColor(.white)
                        .font(.title)
                        .underline()
                        .rotationEffect(.degrees(90))
                        
                    
                    Text("SP02:")
                        .foregroundColor(.white)
                        .font(.title)
                        .underline()
                        .rotationEffect(.degrees(90))
                        
                        
                }
                
                HStack{
                    Text(gzVal)
                        .onReceive(timer) { _ in
                            if currentAz > 16 || currentAz < -16{
                                self.gzVal = "err"
                            }
                            if currentAz <= 16 && currentAz >= -16{
                                self.gzVal = "\(currentAz.rounded(toPlaces: 1))"
                            }
                        }
                        .foregroundColor(.white)
                        .font(.title)
                        .rotationEffect(.degrees(90))
                        .frame(width: 50, height: 100)
                    
                    Text(gyVal)
                        .onReceive(timer) { _ in
                            if currentAy > 16 || currentAy < -16{
                                self.gyVal = "err"
                            }
                            if currentAy <= 16 && currentAy >= -16{
                                self.gyVal = "\(currentAy.rounded(toPlaces: 1))"
                            }
                        }
                        .foregroundColor(.white)
                        .font(.title)
                        .rotationEffect(.degrees(90))
                        .frame(width: 50, height: 100)
                    
                    Text(gxVal)
                        .onReceive(timer) { _ in
                            if currentAx > 16 || currentAx < -16{
                                self.gxVal = "err"
                            }
                            if currentAx <= 16 && currentAx >= -16{
                                self.gxVal = "\(currentAx.rounded(toPlaces: 1))"
                            }
                        }
                        .foregroundColor(.white)
                        .font(.title)
                        .rotationEffect(.degrees(90))
                        .frame(width: 50, height: 100)
                    
                    Text(tempVal)
                        .onReceive(timer) { _ in
                            if currentTemp > 1000 || currentTemp < -50{
                                self.tempVal = "err"
                            }
                            if currentTemp <= 1000 && currentTemp >= -50{
                                
                                switch Settings.TempSelected {
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
                        .font(.title)
                        .rotationEffect(.degrees(90))
                        .frame(width: 50, height: 100)
                    
                    Text(bpmVal)
                        .onReceive(timer) { _ in
                            if currentBPM > 250 || currentBPM < 0{
                                self.bpmVal = "err"
                            }
                            if currentBPM <= 250 && currentBPM >= 0{
                                self.bpmVal = "\(Int(currentBPM))"
                            }
                        }
                        .foregroundColor(.white)
                        .font(.title)
                        .rotationEffect(.degrees(90))
                        .frame(width: 60, height: 100)
                    
                    Text(sp02Val)
                        .onReceive(timer) { _ in
                            if currentSp02 > 200 || currentSp02 < 0{
                                self.sp02Val = "err"
                            }
                            if currentSp02 <= 200 && currentSp02 >= 0{
                                self.sp02Val = "\(Int(currentSp02))%"
                            }
                        }
                        .foregroundColor(.white)
                        .font(.title)
                        .rotationEffect(.degrees(90))
                        .frame(width: 80, height: 100)
                }//.padding(.all,30)
            }
            
        }
    }
}

struct SideBarView_Previews: PreviewProvider {
    static var previews: some View {
        SideBarView()
    }
}
