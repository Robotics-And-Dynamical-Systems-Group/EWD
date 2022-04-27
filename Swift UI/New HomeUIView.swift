//
//  New HomeUIView.swift
//  ePoD
//
//  Created by epod on 3/2/21.
//  Copyright © 2021 Tyler Goudie. All rights reserved.
//

import SwiftUI

struct New_HomeUIView: View {
    
    @State var orientation = UIDevice.current.orientation
    @EnvironmentObject var Settings: AppState
    let TempOrientation = false

    let orientationChanged = NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)
            .makeConnectable()
            .autoconnect()
    
    var body: some View {
        
        Group {
            if orientation.isLandscape  {
                    //Text("LANDSCAPE")
                    ZStack{
                        Color.white.edgesIgnoringSafeArea(.all)
                        VStack{
                            HStack{
                               
                                // Add SideBar View
                               SideBarView()//.aspectRatio(1, contentMode: .fit)
                                    .padding(.trailing)
                                    .padding(.leading)
                                    
                                    
                                
                                // Add Top Side View
                               /* SideTopViewLandscape().aspectRatio(1, contentMode: .fit)
                                    .padding(.trailing)
                                    .rotationEffect(.degrees(90))
                                   */
                                
                            }
                            
                            //Add Graph View
                            GraphViewLandscapeUpdated().aspectRatio(0.65, contentMode: .fit)
                                .padding(.bottom,10)
                                .padding(.top, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                                .padding(.leading)
                                .padding(.trailing)
                                
                        }
                    }
                    
                    
                } else {
                    //Text("PORTRAIT")
                    ZStack{
                        // Background Color Setting
                        Color.white.edgesIgnoringSafeArea(.all)
                        VStack{
                            //Add TopView
                            TopViewPortrait().aspectRatio(2.5, contentMode: .fit)
                                .padding(.bottom,10)
                                .padding(.horizontal)
                            //Add MidView
                            MidViewPortrait().aspectRatio(3.5 , contentMode: .fit)
                                .padding(.bottom,10)
                                .padding(.horizontal)
                                
                            //Add BotView
                            BotViewPortrait().padding(.bottom,10)
                                .padding(.horizontal,7)
                        }
                    }.animation(.easeInOut,value: 1.0)
                }
            }.onReceive(orientationChanged) { _ in
                self.orientation = UIDevice.current.orientation
                    
            }
    }
}

struct New_HomeUIView_Previews: PreviewProvider {
    static var previews: some View {
        //New_HomeUIView().previewLayout(PreviewLayout.fixed(width:896,height:414))
        
        New_HomeUIView()
    }
}
