//
//  Global Varriables.swift
//  ePoD
//
//  Created by Tyler Goudie on 2/26/20.
//  Copyright © 2020 Tyler Goudie. All rights reserved.
//

import Foundation
import UIKit
import CoreBluetooth
import SwiftUICharts
import SwiftUI

var RandomArray = [600.0,500.0,200.0,50.0,-30.0,-250.0,-80.0,10.0,180.0,290.0,500.0]

var SDSaveName = String()
var CodeCompileDate = String()
var CodeCompileName = String()

var bluetoothErr = false
var bleErrMsg = String()
var bleProgress = 0.0


var UTCTime = true
// Varriables for Graphing
var sp02Data = Array(repeating: Double(0), count: 200)
var heartRatePPG = Array(repeating: Double(0), count: 200)
var heartRateBPM = Array(repeating: Double(0), count: 600)
var accelXData = Array(repeating: Double(0), count: 600)
var accelYData = Array(repeating: Double(0), count: 600)
var accelZData = Array(repeating: Double(0), count: 600)
var PPGreddata = Array(repeating: Double(0), count: 200)
//new variable for ekg
var EKGData = Array(repeating: Double(0), count: 200)

var Sp02DataPointSize = 200.0
var PPGDataPointSize = 200.0
var BPMDataPointSize = 600.0
var gXDataPointSize = 600.0
var gyDataPointSize = 600.0
var gzDataPointSize = 600.0
var PPGredDataPointSize = 200.0
//new ekg data point variable
var EKGDataPointSize = 200.0

var botDataPointSize = 200
var topDataPointSize = 200
var lrgGraphDataPointSize = 600

var topGraphSelected = 4
var botGraphSelected = 5
var largeGraphSelected = 4
// Varriables for appending Database
var appendHRPPGGraph = 0
var appendSp02Graph = 0
var appendHRBPMGraph = 0
var appendAccelXGraph = 0
var appendAccelYGraph = 0
var appendAccelZGraph = 0
var appendPPGredGraph = 0
//new var to append ekg to database
var appendEKGGraph = 0
// Varriables for OnScreen Elements
var DeviceTime = ["00:00:00"]

var currentBPM = 0.00
var currentPPG = 0.00
var currentSp02 = 0.00
var currentAx = 0.00
var currentAy = 0.00
var currentAz = 0.00
var currentTemp = 0.00
//new var for current ekg
var currentEKG = 0.00

var bluetoothBtnState = false

var screenSize = UIScreen.main.bounds

// Time|Pulse|SP02|gX|gY|gZ|PPG_IR|R_Ratio|Note|Temperature|PPG_Red|BPM_Red|Sp02_Red|Sp02_Green|R_Ratio|DC_Bias_Red|DC_Bias_Green|EKG
var database = [[""],[""],[""],[""],[""],[""],[""],[""],[""],[""],[""],[""],[""],[""],[""],[""],[""],[""]]
var database2 = [[""],[""],[""],[""],[""],[""],[""],[""],[""],[""],[""],[""],[""],[""],[""],[""],[""],[""]]

var ePodTime = [String]()

var accelX = 0.0
var accelY = 0.0
var accelZ = 0.0

var bleCancel = false

var utcFormat = true

// BLE Varriables
var peripherals:[CBPeripheral] = []
var perphNames:[String] = []

var perphServices:[CBUUID] = [GENERAL_SERVICE_UUID,SENSOR_SERVICE_UUID]
var manager: CBCentralManager!
var connectedPeripheral : CBPeripheral?
var Char : CBCharacteristic?
var ConnectionStatus = false
var SelectionBLEMade = false
var dataTransmission = false
var ConfirmationSent = false
let bluetooth = bleService()
let GENERAL_SERVICE_UUID = CBUUID.init(string: "b2f9b8ba-6459-4268-85e2-95d182f18329")
let GENERAL_CODENAME_CHARACTERISITC_UUID = CBUUID.init(string: "dd42b023-c2c0-4511-a861-1dd7dae3ac9d")
let GENERAL_CODECOMPILEDATE_CHARACTERISTIC_UUID = CBUUID.init(string: "ba2a327a-cf06-4555-85c5-e79058cda88c")
let GENERAL_SDSAVE_CHARACTERISITC_UUID = CBUUID.init(string: "43e75f6d-63d3-49d2-9f3a-0f951738a2a1") // OLD GENERAL CHAR UUID
let GENERAL_CHARACTERISTICS:[CBUUID] = [GENERAL_CODENAME_CHARACTERISITC_UUID,GENERAL_CODECOMPILEDATE_CHARACTERISTIC_UUID,GENERAL_SDSAVE_CHARACTERISITC_UUID]
let SENSOR_SERVICE_UUID  = CBUUID.init(string: "55cefee6-22b2-4b4a-b26d-49da9d0d724c") // OLD ACCEL SERVICE UUID
let SENSOR_CHARACTERISTIC_UUID = CBUUID.init(string: "6bcbdecf-3cba-44c5-8501-791d986d7236")// OLD AX CHAR UUID

//Graph Style Varriables

var GraphStylePurple = ChartStyle(backgroundColor: .clear, accentColor: .blue, gradientColor: GradientColors.purple, textColor: .white, legendTextColor: .white, dropShadowColor: .white)

var GraphStyle2 = ChartStyle(backgroundColor: .clear, accentColor: .black, secondGradientColor: .black, textColor: Color.black, legendTextColor: Color.black, dropShadowColor: Color.black)

var GraphStyleOrange = ChartStyle(backgroundColor: .clear, accentColor: .blue, gradientColor: GradientColors.orange, textColor: .white, legendTextColor: .white, dropShadowColor: .white)

var GraphStyleGreen = ChartStyle(backgroundColor: .clear, accentColor: .blue, gradientColor: GradientColors.green, textColor: .white, legendTextColor: .white, dropShadowColor: .white)

var GraphStyleBlu = ChartStyle(backgroundColor: .clear, accentColor: .blue, gradientColor: GradientColors.blu, textColor: .white, legendTextColor: .white, dropShadowColor: .white)

var GraphStyleBluPurpl = ChartStyle(backgroundColor: .clear, accentColor: .blue, gradientColor: GradientColors.bluPurpl, textColor: .white, legendTextColor: .white, dropShadowColor: .white)

var GraphStylePrplPink = ChartStyle(backgroundColor: .clear, accentColor: .blue, gradientColor: GradientColors.prplPink, textColor: .white, legendTextColor: .white, dropShadowColor: .white)

var GraphStyleOrngPink = ChartStyle(backgroundColor: .clear, accentColor: .blue, gradientColor: GradientColors.orngPink, textColor: .white, legendTextColor: .white, dropShadowColor: .white)

var GraphStyleBlack = ChartStyle(backgroundColor: .clear, accentColor: .black, secondGradientColor: .black, textColor: .white, legendTextColor: .white, dropShadowColor: .white)

var selectedGraphStyle = GraphStylePurple

// Gradient for Instant VC
let colorF27094C = UIColor(hexString: "#f2709c")
let colorFF9472 = UIColor(hexString: "#ff9472")
// Gradient for Graphs VC
let color1CD8D2 = UIColor(hexString: "#1cd8d2")
let color7474BF = UIColor(hexString: "#7474bf")

let colorDAE2F8 = UIColor(hexString: "#dae2f8")
let colorD6A4A4 = UIColor(hexString: "#d6a4a4")

let color9796F0 = UIColor(hexString: "#9796f0")
let colorFBC7d4 = UIColor(hexString: "#fbc7d4")

let color70E1F5 = UIColor(hexString: "#70e1f5")
let colorFFD194 = UIColor(hexString: "#ffd194")

let colorB993D6 = UIColor(hexString: "#b993d6")
let color8CA6DB = UIColor(hexString: "#8ca6db")

let colorFF5858 = UIColor(hexString: "#ff5858")
//Gradient for SP02 Graph Fill
let color5B16C8 = UIColor(hexString: "#5b16c8")
let colorD6BBF9 = UIColor(hexString: "#d6bbf9")

let colorE55D87 = UIColor(hexString: "#e55d87")
let color5FC3E4 = UIColor(hexString: "#5fc3e4")

//Gradient for HR Graph
let colorFF3802 = UIColor(hexString: "#ff3802")
let colorD17379 = UIColor(hexString: "#d17379")

let colorA8CABA = UIColor(hexString: "a8caba", alpha: 0.5)

let colorF3CFC8 = UIColor(hexString: "f3cfc8", alpha: 0.4)

let colorGray1 = UIColor(hexString: "#8389C7")
let colorGray2 = UIColor(hexString: "#7D93B5")


struct AppUtility {
    static func lockOrientation(_ orientation: UIInterfaceOrientationMask){
        if let delegate = UIApplication.shared.delegate as? AppDelegate {
            delegate.orientationLock = orientation
        }
    }
}
