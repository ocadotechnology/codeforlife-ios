//
//  DirectDriveViewController.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 24/06/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import UIKit

class DirectDriveViewController: UIViewController, VehicleController {

    @IBOutlet weak var forwardButton: UIButton!
    @IBOutlet weak var goButton: UIButton!
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
    
    var controller: VehicleController?

    @IBAction func moveForward() {
        self.controller!.moveForward()
    }
    
    @IBAction func turnLeft() {
        controller!.turnLeft()
    }
    
    @IBAction func go() {
        controller!.go()
    }
    
    @IBAction func turnRight() {
        controller!.turnRight()
    }
}
