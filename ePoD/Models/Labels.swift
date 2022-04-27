//
//  Labels.swift
//  ePoD
//
//  Created by Tyler Goudie on 2/23/20.
//  Copyright © 2020 Tyler Goudie. All rights reserved.
//

import Foundation
import UIKit

class Mylabels: UILabel {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initilizeLabel()
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        initilizeLabel()
    }
    
    func initilizeLabel(){
        // Label Size created from Height of Device
        if screenSize.height < 700 {
            self.font = UIFont(name: "Helvetica", size: 22)
            self.textColor = UIColor.white
            //self.layer.borderColor = UIColor.black.cgColor
            //self.layer.borderWidth = 1.0
        }
        if screenSize.height > 700.0 && screenSize.height < 800.0{
            self.font = UIFont(name: "Helvetica", size: 25)
            self.textColor = UIColor.white
            //self.layer.borderColor = UIColor.black.cgColor
            //self.layer.borderWidth = 1.0
        }
        if screenSize.height > 800 {
            self.font = UIFont(name: "Helvetica", size: 25)
            self.textColor = UIColor.white
            //self.layer.borderColor = UIColor.black.cgColor
            //self.layer.borderWidth = 1.0
        }
    }
}

class GraphLabels: UILabel {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initilizeLabel()
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        initilizeLabel()
    }
    
    func initilizeLabel(){
        // Label Size created from Height of Device
        if screenSize.height < 700 {
            self.font = UIFont(name: "Helvetica", size: 20)
            self.textColor = UIColor.white
            //self.layer.borderColor = UIColor.black.cgColor
            //self.layer.borderWidth = 1.0
        }
        if screenSize.height > 700.0 && screenSize.height < 800.0{
            self.font = UIFont(name: "Helvetica", size: 25)
            self.textColor = UIColor.white
            //self.layer.borderColor = UIColor.black.cgColor
            //self.layer.borderWidth = 1.0
        }
        if screenSize.height > 800 {
            self.font = UIFont(name: "Helvetica", size: 26)
            self.textColor = UIColor.white
            //self.layer.borderColor = UIColor.black.cgColor
            //self.layer.borderWidth = 1.0
        }
    }
}

class SettingLabels: UILabel {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initilizeLabel()
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        initilizeLabel()
    }
    
    func initilizeLabel(){
        // Label Size created from Height of Device
        if screenSize.height < 700 {
            self.font = UIFont(name: "Helvetica", size: 16)
            self.textColor = UIColor.black
            //self.layer.borderColor = UIColor.black.cgColor
            //self.layer.borderWidth = 1.0
        }
        if screenSize.height > 700.0 && screenSize.height < 800.0{
            self.font = UIFont(name: "Helvetica", size: 17)
            self.textColor = UIColor.black
            //self.layer.borderColor = UIColor.black.cgColor
            //self.layer.borderWidth = 1.0
        }
        if screenSize.height > 800 {
            self.font = UIFont(name: "Helvetica", size: 17)
            self.textColor = UIColor.black
            //self.layer.borderColor = UIColor.black.cgColor
            //self.layer.borderWidth = 1.0
        }
    }
}
