//
//  DirectDriveViewController.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 24/06/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import UIKit

class DirectDriveViewController: SubGameViewController, VehicleController {
    
    let directDriveFrame = CGSize(width: 245, height: 165)
    let frameOffset: CGFloat = 10

    @IBOutlet weak var forwardButton: DirectDriveButton!
    @IBOutlet weak var goButton: DirectDriveButton!
    @IBOutlet weak var leftButton: DirectDriveButton!
    @IBOutlet weak var rightButton: DirectDriveButton!
    
    var controller: VehicleController?
    
    override var gameViewController: GameViewController? {
        didSet {
            controller = NativeCarController(gameViewController: gameViewController!)
            //controller = CargoController(gameViewController: gameViewController!)
        }
    }
    
    override var frame: CGRect {
        return CGRect(
            x: self.gameViewController!.view.frame.width - directDriveFrame.width - frameOffset,
            y: self.gameViewController!.view.frame.height - directDriveFrame.height - frameOffset,
            width: directDriveFrame.width,
            height: directDriveFrame.height)
    }

    @IBAction func moveForward() {
        gameViewController?.blockTableViewController?.addBlock(Forward())
        controller!.moveForward()
    }
    
    @IBAction func turnLeft() {
        gameViewController?.blockTableViewController?.addBlock(Left())
        controller!.turnLeft()
    }
    
    @IBAction func go() {
        controller!.go()
    }
    
    @IBAction func turnRight() {
        gameViewController?.blockTableViewController?.addBlock(Right())
        controller!.turnRight()
    }
    
    func disableDirectDrive() {
        forwardButton.enabled = false
        goButton.enabled = false
        leftButton.enabled = false
        rightButton.enabled = false
    }
    
    func enableDirectDrive() {
        forwardButton.enabled = true
        goButton.enabled = true
        leftButton.enabled = true
        rightButton.enabled = true
    }
}
