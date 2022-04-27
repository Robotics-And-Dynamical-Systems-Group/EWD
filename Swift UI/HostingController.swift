//
//  HostingController.swift
//  ePoD
//
//  Created by Tyler Goudie on 6/30/20.
//  Copyright © 2020 Tyler Goudie. All rights reserved.
//

import UIKit
import SwiftUI


class HostingController: UIHostingController<New_HomeUIView> {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        print("Setting to Dark")
        return .darkContent
    }
}
