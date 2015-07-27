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
        if let nextLevelUrl = SharedContext.MainGameViewController!.level?.nextLevelUrl {
            SharedContext.MainGameViewController?.levelUrl = nextLevelUrl
            println("Next Level Url = \(nextLevelUrl)")
        }
    }
    
    func playAgainAndDismiss() {
        SharedContext.MainGameViewController?.blockTableViewController?.clearBlocks()
        SharedContext.MainGameViewController?.gameMapViewController?.map?.van.reset()
        SharedContext.MainGameViewController?.gameMapViewController?.map?.resetMap()
        SharedContext.MainGameViewController?.gameMapViewController?.animationHandler.resetVariables()
        ActionFactory.createAction("ChangeToOnStopControls").execute()
    }
    
//    deinit { println("MessageViewController is being deallocated") }

}
