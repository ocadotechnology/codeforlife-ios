//
//  DirectDriveCommand.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 06/07/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import Foundation

class DirectDriveCommand: GameViewCommand {

    weak var viewController : DirectDriveViewController? {
        return gameViewController?.directDriveViewController
    }

}

class NGVDisableDirectDriveCommand: DirectDriveCommand {
    override func execute(completion: (() -> Void)? = nil) {
        viewController?.disableDirectDrive()
        completion?()
    }
}

class NGVEnableDirectDriveCommand: DirectDriveCommand {
    override func execute(completion: (() -> Void)? = nil) {
        viewController?.enableDirectDrive()
        completion?()
    }
}