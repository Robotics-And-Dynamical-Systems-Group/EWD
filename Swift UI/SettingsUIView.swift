//
//  SettingsUIView.swift
//  ePoD
//
//  Created by Tyler Goudie on 7/13/20.
//  Copyright © 2020 Tyler Goudie. All rights reserved.
//

import SwiftUI

struct SettingsUIView: View {
   
    @State var TSelection = ["Farenhiet","Celsius", "Kelvin"]
    @State var GsSelection = ["Prpl","Blu","Grn","Orng","BluPrpl","PrplPnk","OrngPnk","Blk"]
    @State var Sp02DataSize = Sp02DataPointSize
    @State var PPGDataSize = PPGDataPointSize
    @State var BPMDataSize = BPMDataPointSize
    @State var GXDataSize = gXDataPointSize
    @State var GYDataSize = gyDataPointSize
    @State var GZDataSize = gzDataPointSize
    @ObservedObject var Settings: AppState = .shared
    
    
    var body: some View {
        
        ZStack{
            Color.white
                .edgesIgnoringSafeArea(.all)
            VStack{
                Text("Settings")
                    .foregroundColor(.black)
                    .font(SettingsFontSize1())
                    .position(x: screenSize.width*0.5, y: 20)
                
                HStack{
                    Text("Enable Cordinated Universal Time")
                        .foregroundColor(.black)
                        .font(SettingsFontSize2())
                    Toggle("UTC Toggle",isOn: $Settings.UTCEnabled )
                        .labelsHidden()
                }.padding(.bottom,20)
                .position(x: screenSize.width*0.5, y: 20)
                
                Text("Temperature Type")
                    .foregroundColor(.black)
                    .font(SettingsFontSize2())
                
                Picker(selection: $Settings.TempSelected, label: Text("Tempature Settings").foregroundColor(.black), content: {
                    ForEach(0..<TSelection.count) {
                        index in Text(self.TSelection[index]).tag(index)
                    }
                    
                }).padding(EdgeInsets(top: 10, leading: 20, bottom: 20, trailing: 20))
                .foregroundColor(.white)
                .pickerStyle(SegmentedPickerStyle())
                
                Text("Graph Line Color")
                    .foregroundColor(.black)
                    .font(SettingsFontSize2())
                
                Picker(selection: $Settings.GraphSelection, label: Text("Graph Styles"), content: {
                    ForEach(0..<GsSelection.count) {
                        index in Text(self.GsSelection[index]).tag(index)
                    }
                }).padding(EdgeInsets(top: 10, leading: 10, bottom: 20, trailing: 10))
                .foregroundColor(.white)
                .pickerStyle(SegmentedPickerStyle())
                            
                
                Group{
                Text("Sp02 DataSet Size: \(String(format: "%.1f", Sp02DataSize)) Points")
                    .foregroundColor(.black)
                    .font(SettingsFontSize2())
                    .padding(EdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 0))
                Slider(value: $Sp02DataSize, in: 50...600, step: 1.0, onEditingChanged: {_ in sp02Data = Array(repeating: Double(0), count: Int(self.Sp02DataSize))
                    Sp02DataPointSize = self.Sp02DataSize
                }).frame(width: screenSize.width*0.8, height: 30)
                
                Text("PPG DataSet Size: \(String(format: "%.1f", PPGDataSize)) Points")
                    .foregroundColor(.black)
                    .font(SettingsFontSize2())
                    .padding(EdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 0))
                Slider(value: $PPGDataSize, in: 50...600, step: 1.0, onEditingChanged: {_ in heartRatePPG = Array(repeating: Double(0), count: Int(self.PPGDataSize))
                    PPGDataPointSize = self.PPGDataSize
                }).frame(width: screenSize.width*0.8, height: 30)
                
                Text("BPM DataSet Size: \(String(format: "%.1f", BPMDataSize)) Points")
                    .foregroundColor(.black)
                    .font(SettingsFontSize2())
                    .padding(EdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 0))
                Slider(value: $BPMDataSize, in: 50...600, step: 1.0, onEditingChanged: {_ in heartRateBPM = Array(repeating: Double(0), count: Int(self.BPMDataSize))
                    BPMDataPointSize = self.BPMDataSize
                }).frame(width: screenSize.width*0.8, height: 30)
                }.position(x: screenSize.width*0.5, y: 0)
                Group{
                Text("g-x DataSet Size: \(String(format: "%.1f", GXDataSize)) Points")
                    .foregroundColor(.black)
                    .font(SettingsFontSize2())
                    .padding(EdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 0))
                Slider(value: $GXDataSize, in: 50...600, step: 1.0, onEditingChanged: {_ in accelXData = Array(repeating: Double(0), count: Int(self.GXDataSize))
                    gXDataPointSize = self.GXDataSize
                }).frame(width: screenSize.width*0.8, height: 30)
                
                Text("g-y DataSet Size: \(String(format: "%.1f", GYDataSize)) Points")
                    .foregroundColor(.black)
                    .font(SettingsFontSize2())
                    .padding(EdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 0))
                Slider(value: $GYDataSize, in: 50...600, step: 1.0, onEditingChanged: {_ in accelYData = Array(repeating: Double(0), count: Int(self.GYDataSize))
                    gyDataPointSize = self.GYDataSize
                }).frame(width: screenSize.width*0.8, height: 30)
                
                Text("g-z DataSet Size: \(String(format: "%.1f", GZDataSize)) Points")
                    .foregroundColor(.black)
                    .font(SettingsFontSize2())
                    .padding(EdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 0))
                Slider(value: $GZDataSize, in: 50...600, step: 1.0, onEditingChanged: {_ in accelZData = Array(repeating: Double(0), count: Int(self.GZDataSize))
                    gzDataPointSize = self.GZDataSize
                }).frame(width: screenSize.width*0.8, height: 30)
                }.position(x: screenSize.width*0.5, y: 0)
                
                Text("Version 1.3")
                    .foregroundColor(.black)
                    .font(SettingsFontSize2())
                
                
            }
        }
        .environmentObject(Settings)
    }
}


func SettingsFontSize1() -> Font{
    var selectedFont = UIFont()
    if screenSize.height < 700 {
        selectedFont = UIFont(name: "Helvetica", size: 24)!
        
    }
    if screenSize.height > 700.0 && screenSize.height < 800.0{
        selectedFont = UIFont(name: "Helvetica", size: 28)!
       
    }
    if screenSize.height > 800 {
        selectedFont = UIFont(name: "Helvetica", size: 30)!
        
    }
    return Font(selectedFont)
}
func SettingsFontSize2() -> Font{
    var selectedFont = UIFont()
    if screenSize.height < 700 {
        selectedFont = UIFont(name: "Helvetica", size: 12)!
        
    }
    if screenSize.height > 700.0 && screenSize.height < 800.0{
        selectedFont = UIFont(name: "Helvetica", size: 12)!
       
    }
    if screenSize.height > 800 {
        selectedFont = UIFont(name: "Helvetica", size: 18)!
        
    }
    return Font(selectedFont)
}
