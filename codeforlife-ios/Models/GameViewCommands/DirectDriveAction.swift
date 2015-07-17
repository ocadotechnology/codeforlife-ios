//
//  DirectDriveAction.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 06/07/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import Foundation

class DirectDriveAction: GameViewAction {

    weak var viewController : DirectDriveViewController? {
        return gameViewController?.directDriveViewController
    }

}

class NGVDisableDirectDriveAction: DirectDriveAction {
    override func execute(completion: (() -> Void)? = nil) {
        viewController?.disableDirectDrive()
        completion?()
    }
}

class NGVEnableDirectDriveAction: DirectDriveAction {
    override func execute(completion: (() -> Void)? = nil) {
        viewController?.enableDirectDrive()
        completion?()
    }
}