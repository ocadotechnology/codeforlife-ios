//
//  CargoController.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 23/06/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import Foundation

protocol VehicleController {
    func moveForward()
    func turnLeft()
    func turnRight()
    func go()
}

class CargoController: VehicleController {
    
    let moveForwardJavaScript = "$('#moveForward').trigger('click');"
    let turnLeftJavaScript = "$('#turnLeft').trigger('click');"
    let turnRightJavaScript = "$('#turnRight').trigger('click');"
    let goJavaScript = "$('#play_radio').trigger('click');"
    
    var gameViewController: GameViewController
    
    init(gameViewController: GameViewController) {
        self.gameViewController = gameViewController
    }
    
    func moveForward() {
        gameViewController.runJavaScript(moveForwardJavaScript)
    }
    
    func turnLeft() {
        gameViewController.runJavaScript(turnLeftJavaScript)
    }
    
    func turnRight() {
        gameViewController.runJavaScript(turnRightJavaScript)
    }
    
    func go() {
        gameViewController.runJavaScript(goJavaScript)
    }
    
}

class NativeCarController: VehicleController {
    
    var car : Player
    
    init(gameViewController: GameViewController) {
        car = gameViewController.gameMapViewController!.skView!.gameScene!.player
    }
    
    func moveForward() {
        car.moveForward(50, duration: 1)
    }
    
    func turnLeft() {
        car.turnLeft(50, duration: 1)
    }
    
    func turnRight() {
        car.turnRight(50, duration: 1)
    }
    
    func go() {
    }
    
}