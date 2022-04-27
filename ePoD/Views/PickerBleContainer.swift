//
//  PickerBleContainer.swift
//  ePoD
//
//  Created by Tyler Goudie on 3/15/20.
//  Copyright © 2020 Tyler Goudie. All rights reserved.
//

import UIKit

class PickerBleContainer: UIView {

   override init(frame: CGRect) {
       super.init(frame: frame)
       self.backgroundColor = .white
       self.translatesAutoresizingMaskIntoConstraints = false
   }
   
   required init?(coder: NSCoder) {
       fatalError("init(coder:) has not been implemented")
   }
   
}
