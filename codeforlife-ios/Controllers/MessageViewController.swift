//
//  HelpViewController.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 26/06/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import UIKit

class MessageViewController: SubGameViewController {
    
    let messageFrame = CGSize(width: 500, height: 500)
    
    let containerViewCornerRadius: CGFloat = 50
    let containerViewBorderWidth: CGFloat = 10
    let messageButtonBorderWidth: CGFloat = 5
    let messageButtonCornerRadius: CGFloat = 25
    
    var hidePosition: CGPoint {
        return CGPointMake(
            self.view.center.x,
            gameViewController!.view.frame.height + messageFrame.height/2)
    }
    
    var showPosition: CGPoint {
        return gameViewController!.view.center
    }
    
    override var frame: CGRect {
        return CGRect(
            x: self.gameViewController!.view.center.x - messageFrame.width/2,
            y: self.gameViewController!.view.frame.height,
            width: messageFrame.width,
            height: messageFrame.height)
    }
    
    var message: Message? {
        didSet {
            self.view = message?.view
        }
    }
    
    
    private var open = false {
        didSet {
            UIView.animateWithDuration(0.5) {
                self.view.center = self.open ? self.showPosition: self.hidePosition
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func executeButtonAction() {
        message?.action?()
    }
    
    func toggleMenu() {
        open = !open
    }
    
    func openMenu() {
        open = true
    }
    
    func closeMenu() {
        open = false
    }
    
    func gotoNextLevelAndDismiss() {
        if let nextLevel = gameViewController!.level?.nextLevel {
            gameViewController!.level = nextLevel
        }
        closeMenu()
    }
    
    func playAgainAndDismiss() {
        self.gameViewController!.level = self.gameViewController!.level
        closeMenu()
    }

}
