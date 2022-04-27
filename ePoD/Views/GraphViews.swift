//
//  GraphViews.swift
//  ePoD
//
//  Created by Tyler Goudie on 2/23/20.
//  Copyright © 2020 Tyler Goudie. All rights reserved.
//

import UIKit

class GraphViews: UIView {

    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
       
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    func setupView() {
        self.backgroundColor = UIColor.magenta
    }

}
