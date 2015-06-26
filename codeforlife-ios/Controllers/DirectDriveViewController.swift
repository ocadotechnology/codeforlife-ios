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

    @IBOutlet weak var forwardButton: UIButton!
    @IBOutlet weak var goButton: UIButton!
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
    
    var controller: VehicleController?
    
    var gameViewController: GameViewController? {
        didSet {
            controller = CargoController(gameViewController: gameViewController!)
        }
    }
    
    var frame: CGRect {
        return CGRect(
            x: self.gameViewController!.view.frame.width - directDriveFrame.width - 5,
            y: self.gameViewController!.view.frame.height - directDriveFrame.height - 5,
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
