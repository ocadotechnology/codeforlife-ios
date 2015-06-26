//
//  DirectDriveViewController.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 24/06/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import UIKit

class DirectDriveViewController: UIViewController, VehicleController {
    
    
    let directDriveFrame = CGSize(width: 245, height: 165)

    @IBOutlet weak var forwardButton: DirectDriveButton!
    @IBOutlet weak var goButton: DirectDriveButton!
    @IBOutlet weak var leftButton: DirectDriveButton!
    @IBOutlet weak var rightButton: DirectDriveButton!
    
    var controller: VehicleController?
    
    var gameViewController: GameViewController? {
        didSet {
            controller = CargoController(gameViewController: gameViewController!)
        }
    }
    
    var frame: CGRect {
        return CGRect(
            x: self.gameViewController!.view.frame.width - directDriveFrame.width - 10,
            y: self.gameViewController!.view.frame.height - directDriveFrame.height - 10,
            width: directDriveFrame.width,
            height: directDriveFrame.height)
    }

    @IBAction func moveForward() {
        controller!.moveForward()
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
