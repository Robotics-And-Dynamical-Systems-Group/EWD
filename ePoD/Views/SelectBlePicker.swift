//
//  SelectBlePicker.swift
//  ePoD
//
//  Created by Tyler Goudie on 3/15/20.
//  Copyright © 2020 Tyler Goudie. All rights reserved.
//

import UIKit

class SelectBlePicker: UIPickerView {

    //let bleToolbar = UIToolbar()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.masksToBounds = true
        //toolbarSetup()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
