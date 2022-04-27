//
//  SideBotViewLandscape.swift
//  ePoD
//
//  Created by epod on 3/9/21.
//  Copyright © 2021 Tyler Goudie. All rights reserved.
//

import SwiftUI

struct SideBotViewLandscape: View {
    
    let timer = Timer.publish(every: 0.25, on: .main, in: .common).autoconnect()
    
    @State var gxVal = String()
    @State var gyVal = String()
    @State var gzVal = String()
    @State var sp02Val = String()
    @State var bpmVal = String()
    @State var tempVal = String()
    @State var tempSelection = ["F°","C°","K°"]
    @State var tempSelected = 0
    
    
    var body: some View {
        ZStack{
            Rectangle()
                .fill(LinearGradient(gradient: orangeGradient, startPoint: .topLeading, endPoint: .bottomTrailing)).cornerRadius(20.0)
            VStack{
            HStack{
                
                
                Group{
                Text("g-x:")
                    .foregroundColor(.white)
                    .font(.title)
                    .underline()
                
                }.rotationEffect(.degrees(90))
            
                
                Group{
                Text("g-y:")
                    .foregroundColor(.white)
                    .font(.title)
                    .underline()
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
                    .font(.title2)
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 5))
                }.rotationEffect(.degrees(90))
                
                Group{
                Text("g-z:")
                    .foregroundColor(.white)
                    .font(.title)
                    .underline()
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
                    .font(.title2)
                }.rotationEffect(.degrees(90))
                
                Group{
                Text("\(tempSelection[self.tempSelected]):")
                    .foregroundColor(.white)
                    .font(.title)
                    .underline()
                Text(tempVal)
                    .onReceive(timer) { _ in
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
                    }.font(.title2)
                }.rotationEffect(.degrees(90))
                
                
                Group{
                Text("SP02:")
                    .foregroundColor(.white)
                    .font(.title)
                    .underline()
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
                    .font(.title2)
                }.rotationEffect(.degrees(90))
                
                Group{
                    HStack{
                    Text("BPM:")
                        .foregroundColor(.white)
                        .font(.title)
                        .underline()
                        
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
                        .font(.title2)
                    }
                }
                .rotationEffect(.degrees(90))
                HStack{
                    
                }
            }
            }
        }
    }
}

struct SideBotViewLandscape_Previews: PreviewProvider {
    static var previews: some View {
        SideBotViewLandscape()
    }
}
