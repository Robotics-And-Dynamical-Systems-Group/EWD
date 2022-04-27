//
//  UIStateVars.swift
//  ePoD
//
//  Created by epod on 4/24/21.
//  Copyright © 2021 Tyler Goudie. All rights reserved.
//

import Foundation

class AppState: ObservableObject{
    private init() { }
    
    static let shared = AppState()
    
    @Published var TempSelected = 0
    @Published var GraphSelection = 0
    @Published var UTCEnabled = true
}
