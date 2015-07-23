//
//  HelpViewController.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 26/06/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import UIKit

class MessageViewController: UIViewController {
    
    let containerViewCornerRadius: CGFloat = 50
    let containerViewBorderWidth: CGFloat = 10
    let messageButtonBorderWidth: CGFloat = 5
    let messageButtonCornerRadius: CGFloat = 25
    
    weak var message: Message? {
        didSet {
            self.view = message?.view
        }
    }
    
    func executeButtonAction() {
        message?.action?()
    }
    
    func gotoNextLevelAndDismiss() {
        if let nextLevel = SharedContext.MainGameViewController!.level?.nextLevel {
            SharedContext.MainGameViewController?.level = nextLevel
        }
    }
    
    func playAgainAndDismiss() {
        SharedContext.MainGameViewController?.blockTableViewController?.clearBlocks()
        SharedContext.MainGameViewController?.gameMapViewController?.map?.van.reset()
        SharedContext.MainGameViewController?.gameMapViewController?.map?.resetMap()
        SharedContext.MainGameViewController?.gameMapViewController?.animationHandler.resetVariables()
        CommandFactory.createCommand("ChangeToOnStopControls").execute()
    }
    
//    deinit { println("MessageViewController is being deallocated") }

}
