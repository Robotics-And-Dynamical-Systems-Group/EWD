//
//  InstantaniousDataView.swift
//  ePoD
//
//  Created by Tyler Goudie on 2/23/20.
//  Copyright © 2020 Tyler Goudie. All rights reserved.
//

import UIKit

class InstantaniousDataView: UIView {
    var timeLabel = Mylabels()
    

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
       
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    func setupView(){
        print("SettingUpInstantaniousView")
        self.backgroundColor = UIColor.blue
        
        timeLabel = Mylabels(frame: CGRect(x: self.frame.size.width/3, y: self.frame.size.height/3, width: self.frame.size.width/4, height: self.frame.size.height/5 ))
        
        
        self.addSubview(timeLabel)
    }

}
