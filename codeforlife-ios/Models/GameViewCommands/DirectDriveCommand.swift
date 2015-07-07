//
//  DirectDriveCommand.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 06/07/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import Foundation

class DirectDriveCommand: GameViewCommand {
    
}

class NGVDisableDirectDriveCommand: DirectDriveCommand {
    override func executeWithCompletionHandler(completion: () -> Void) {
        gameViewController.directDriveViewController.disableDirectDrive()
    }
}

class NGVEnableDirectDriveCommand: DirectDriveCommand {
    override func executeWithCompletionHandler(completion: () -> Void) {
        gameViewController.directDriveViewController.enableDirectDrive()
    }
}