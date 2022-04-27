//
//  Bluetooth.swift
//  ePoD
//
//  Created by Tyler Goudie on 2/23/20.
//  Copyright © 2020 Tyler Goudie. All rights reserved.
//

import Foundation
import CoreBluetooth


class bleService : NSObject, CBCentralManagerDelegate, CBPeripheralDelegate{
    
    private var generalChar : CBCharacteristic?

    public override init() {
        super.init()
        manager = CBCentralManager.init(delegate: self, queue: DispatchQueue.global())
        manager.delegate = self
    }
    //MARK: Externally Accessable Funtions
    func bleInit (){
        print("bleInit")
        centralManagerDidUpdateState(manager)
    }
    
    func connectToPerph(peripheral: CBPeripheral){
        print("Device Found!")
        SelectionBLEMade = true
        centralManagerDidUpdateState(manager)
        
    }
    func sendConfirmation(){
        let val = "1"
        let dataToSend = Data(val.utf8)
        ConfirmationSent = true

        if (generalChar?.properties.contains(.write))! {
            connectedPeripheral?.writeValue(dataToSend as Data, for: generalChar!, type: .withoutResponse)
            
        }
    }
    
    
    func CharDatatoString(data: Data) -> String {
        let str = String(decoding: data, as: UTF8.self)
        return str
    }
    //MARK: Data Extrapolation
    func dataExtrapolation(data: Data, location: Int) -> String {
        let str = String(decoding: data, as: UTF8.self)
        //print(str)
        let strArray = str.components(separatedBy: ";")
        //print(strArray)
        if location > strArray.count-1 { return "0" }
        else {return strArray[location]}
    }
    
    func appendHRPPG(value: Double){
        
        if appendHRPPGGraph >= heartRatePPG.count {
            appendHRPPGGraph = 0
            heartRatePPG[appendHRPPGGraph] = value
        }
        else {
            heartRatePPG[appendHRPPGGraph] = value
        }
        appendHRPPGGraph = appendHRPPGGraph + 1
    }
    
    func appendSp02(value: Double){
        if appendSp02Graph >= sp02Data.count {
            appendSp02Graph = 0
            sp02Data[appendSp02Graph] = value
        }
        else{
            sp02Data[appendSp02Graph] = value
            appendSp02Graph = appendSp02Graph + 1
        }
    }
    
    func appendBPM(value: Double){
        if appendHRBPMGraph >= heartRateBPM.count{
            appendHRBPMGraph = 0
            heartRateBPM[appendHRBPMGraph] = value
        }
        else{
            heartRateBPM[appendHRBPMGraph] = value
            appendHRBPMGraph = appendHRBPMGraph + 1
        }
    }
    
    func appendAX(value: Double){
        if appendAccelXGraph >= accelXData.count{
            appendAccelXGraph = 0
            accelXData[appendAccelXGraph] = value
        }
        else {
            accelXData[appendAccelXGraph] = value
            appendAccelXGraph = appendAccelXGraph + 1
        }
    }
    
    func appendAY(value: Double){
        if appendAccelYGraph >= accelYData.count{
            appendAccelYGraph = 0
            accelYData[appendAccelYGraph] = value
        }
        else {
            accelYData[appendAccelYGraph] = value
            appendAccelYGraph = appendAccelYGraph + 1
        }
    }
    
    func appendAZ(value: Double){
        if appendAccelZGraph >= accelZData.count{
            appendAccelZGraph = 0
            accelZData[appendAccelZGraph] = value
        }
        else {
            accelZData[appendAccelZGraph] = value
            appendAccelZGraph = appendAccelZGraph + 1
        }
    }
    
    func appendPPGred(value: Double){
        if appendPPGredGraph >= PPGreddata.count{
            appendPPGredGraph = 0
            PPGreddata[appendPPGredGraph] = value
        }
        else {
            PPGreddata[appendPPGredGraph] = value
            appendPPGredGraph = appendPPGredGraph + 1
        }
    }
    
    func disconnectPeripheral() {
        if connectedPeripheral == nil {
            
        }
        else{
        manager.cancelPeripheralConnection(connectedPeripheral!)
        }
    }
    
    //MARK: Bluetooth Connection Setup
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        var consoleMsg = ""
        
        
        switch central.state {
        case .poweredOff:
            consoleMsg = "BLE Powered Off"
        case .poweredOn:
            consoleMsg = "BLE Powered On"
            manager.scanForPeripherals(withServices: [GENERAL_SERVICE_UUID] , options: nil)
        case .resetting:
            consoleMsg = "BLE Resetting"
        case .unauthorized:
            consoleMsg = "BLE is Unathorized"
        case .unknown:
            consoleMsg = "BLE is Unknown"
        case .unsupported:
            consoleMsg = "Ble is Not Supported"
        default: break
                
        }
        print("\(consoleMsg)")
        
    }

    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        
        print("Peripheral: \(peripheral)")
        // creates an array of peripherals that have the same public service
        if (!perphNames.contains(peripheral.name!) && ConnectionStatus == false){
            print(perphNames)
            peripherals.append(peripheral)
            perphNames.append(peripheral.name ?? "unknown")
            
        }
        if SelectionBLEMade == true {
            connectedPeripheral = peripheral
            connectedPeripheral?.delegate = self
            manager.stopScan()
            manager.connect(connectedPeripheral!, options: nil)
        }
    }

    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        print("didConnect")
        print("Connection Finalized to ESP32!")
        ConnectionStatus = true
        connectedPeripheral?.discoverServices(perphServices)
        print("End")
        
    }
    //Finding Characteristics from Services
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        print("didDiscoverServices")
        if let services = peripheral.services{
            for service in services{
                print("Service Characteristics: \(service)")
                if service.uuid == GENERAL_SERVICE_UUID {
                    peripheral.discoverCharacteristics(GENERAL_CHARACTERISTICS, for: service)
                    bleProgress = bleProgress + 1
                }
                if service.uuid == SENSOR_SERVICE_UUID {
                    peripheral.discoverCharacteristics([SENSOR_CHARACTERISTIC_UUID], for: service)
                    bleProgress = bleProgress + 1
                }
                
            }
        }
    }
    
    // Setting up Charactersitc Properties
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        if let characteristics = service.characteristics {
            for characteristic in characteristics{
                // General Characteristic
                if characteristic.uuid == GENERAL_SDSAVE_CHARACTERISITC_UUID{
                    if characteristic.properties.contains(.read) {
                        print("\(characteristic.uuid): properties contains .read")
                    }
                    if characteristic.properties.contains(.notify) {
                        print("\(characteristic.uuid): properties contains .notify")
                        peripheral.setNotifyValue(true, for: characteristic)
                    }
                    
                    bleProgress = bleProgress + 1
                }
                if characteristic.uuid == GENERAL_CODECOMPILEDATE_CHARACTERISTIC_UUID{
                   if characteristic.properties.contains(.read) {
                       print("\(characteristic.uuid): properties contains .read")
                   }
                   if characteristic.properties.contains(.notify) {
                       print("\(characteristic.uuid): properties contains .notify")
                       peripheral.setNotifyValue(true, for: characteristic)
                   }
                    bleProgress = bleProgress + 1
               }
                if characteristic.uuid == GENERAL_CODENAME_CHARACTERISITC_UUID{
                   if characteristic.properties.contains(.read) {
                       print("\(characteristic.uuid): properties contains .read")
                   }
                   if characteristic.properties.contains(.notify) {
                       print("\(characteristic.uuid): properties contains .notify")
                       peripheral.setNotifyValue(true, for: characteristic)
                   }
                    bleProgress = bleProgress + 1
               }
                if characteristic.uuid == SENSOR_CHARACTERISTIC_UUID {
                   if characteristic.properties.contains(.read) {
                       print("\(characteristic.uuid): properties contains .read")
                   }
                   if characteristic.properties.contains(.notify) {
                       print("\(characteristic.uuid): properties contains .notify")
                       peripheral.setNotifyValue(true, for: characteristic)
                   }
                    bleProgress = bleProgress + 1
               }
            }
        }
    }
    
    // Handle Any Accidental Disconnects
    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
        
        if error?.localizedDescription != nil {
            print("ERROR: \(String(describing: error!.localizedDescription))")
            bleErrMsg = String(describing: error!.localizedDescription)
            bluetoothErr = true
        }
        
        
        
        print("Peripheral Disconnected")
        ConnectionStatus = false
        SelectionBLEMade = false
        ConfirmationSent = false
        connectedPeripheral = nil
        //conversion = 0.0
        bleProgress = 0.0
        peripherals = []
        perphNames = []
        
        // start scanning again
        print("Starting Scan")
        bleInit()
        
    }
    
    //MARK: Characteristic Updates
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
       //print(conversion)
        
        if bleProgress == 6 {
        
            switch characteristic.uuid {
                
            case SENSOR_CHARACTERISTIC_UUID:
                
                //Time
                guard let data = characteristic.value else { return }
                var value = dataExtrapolation(data: data, location: 0)
                ePodTime.append(value)
                print("EpodTime: \(value)")
                //SP02
                value = dataExtrapolation(data: data, location: 2)
                appendSp02(value: (value as NSString).doubleValue)
                currentSp02 = (value as NSString).doubleValue
                database[1].append(value)
                print("Sp02: \(value)")
                //PPG_IR
                value = dataExtrapolation(data: data, location: 6)
                appendHRPPG(value: (value as NSString).doubleValue)
                currentPPG = (value as NSString).doubleValue
                database[5].append(value)
                print("PPG: \(value)")
                //Pulse
                value = dataExtrapolation(data: data, location: 1)
                appendBPM(value: (value as NSString).doubleValue)
                currentBPM = (value as NSString).doubleValue
                database[0].append(value)
                print("BPM: \(value)")
                //gX
                value = dataExtrapolation(data: data, location: 3)
                appendAX(value: (value as NSString).doubleValue)
                currentAx = (value as NSString).doubleValue
                database[2].append(value)
                print("gX: \(value)")
                //gY
                value = dataExtrapolation(data: data, location: 4)
                appendAY(value: (value as NSString).doubleValue)
                currentAy = (value as NSString).doubleValue
                database[3].append(value)
                print("AY: \(value)")
                //Gz
                value = dataExtrapolation(data: data, location: 5)
                appendAZ(value: (value as NSString).doubleValue)
                currentAz = (value as NSString).doubleValue
                database[4].append(value)
                print("AZ: \(value)")
                //R_Ratio_Red
                value = dataExtrapolation(data: data, location: 7)
                database[6].append(value)
                print("R_Ratio_Red: \(value)")
                //Note
                value = dataExtrapolation(data: data, location: 8)
                database[7].append(value)
                print("BEAT/RESET: \(value)")
                //Temperature
                value = dataExtrapolation(data: data, location: 9)
                currentTemp = (value as NSString).doubleValue
                database[8].append(value)
                print("TEMP: \(value)")
                //PPG_Red
                value = dataExtrapolation(data: data, location: 10)
                appendPPGred(value: (value as NSString).doubleValue * 3)
                database[9].append(value)
                print("PPGRed: \(value)")
                //BPM_Red
                value = dataExtrapolation(data: data, location: 11)
                database2[0].append(value)
                print("BPM_Red: \(value)")
                //SP02_Red
                value = dataExtrapolation(data: data, location: 12)
                database2[1].append(value)
                print("SP02_Red: \(value)")
                //BPM_Green
                value = dataExtrapolation(data: data, location: 13)
                database2[2].append(value)
                print("BPM_Green: \(value)")
                //SP02_Green
                value = dataExtrapolation(data: data, location: 14)
                database2[3].append(value)
                print("SP02_Green: \(value)")
                //R_Ratio_Green
                value = dataExtrapolation(data: data, location: 15)
                database2[4].append(value)
                print("R_Ratio_Green: \(value)")
                //DC_Bias_Red
                value = dataExtrapolation(data: data, location: 16)
                database2[5].append(value)
                print("DC_Bias_Red: \(value)")
                //DC_Bias_Green
                value = dataExtrapolation(data: data, location: 17)
                database2[6].append(value)
                print("DC_Bias_Green: \(value)")
                
                
                let date = Date()
                let df = DateFormatter()
                var t = String()
                
                if utcFormat == true{
                    df.dateFormat = "HH:mm:ss"
                    df.timeZone = NSTimeZone(abbreviation: "UTC") as TimeZone?
                    t = df.string(from: date) + "_UTC"
                    
                }
                else {
                    df.dateFormat = "HH:mm:ss"
                    t = df.string(from: date) + "_" + TimeZone.current.abbreviation()!
                }
                DeviceTime.append(t)
                
                break
                
            case GENERAL_SDSAVE_CHARACTERISITC_UUID:
                guard let data = characteristic.value else { return }
                SDSaveName = CharDatatoString(data: data)
                break
            
            case GENERAL_CODENAME_CHARACTERISITC_UUID:
                //print("CodeNameRecieved")
                guard let data = characteristic.value else { return }
                CodeCompileName = CharDatatoString(data: data)
                break
            
            case GENERAL_CODECOMPILEDATE_CHARACTERISTIC_UUID:
                //print("CodeCompileDateRecieved")
                guard let data = characteristic.value else { return }
                CodeCompileDate = CharDatatoString(data: data)
                break
                
            default:
                break
                }
            
        }
        
    }
}

