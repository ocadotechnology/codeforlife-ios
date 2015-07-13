//
//  HelpViewController.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 26/06/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import UIKit

class MessageViewController: SubGameViewController {
    
    static func MessageViewControllerInstance() -> MessageViewController {
        return UIStoryboard(name: "Main", bundle: NSBundle.mainBundle()).instantiateViewControllerWithIdentifier("MessageViewController") as! MessageViewController
    }
    
    let messageFrame = CGSize(width: 500, height: 500)
    
    let containerViewCornerRadius: CGFloat = 50
    let containerViewBorderWidth: CGFloat = 10
    let messageButtonBorderWidth: CGFloat = 5
    let messageButtonCornerRadius: CGFloat = 25
    
    var hidePosition: CGPoint {
        return CGPointMake(
            gameViewController.view.center.x,
            gameViewController.view.frame.height + messageFrame.height/2)
    }
    
    var showPosition: CGPoint {
        return gameViewController.view.center
    }
    
    weak var message: Message? {
        didSet {
            self.view = message?.view
        }
    }
    
    var open = false {
        didSet {
            UIView.animateWithDuration(0.5) {
                self.view.center = self.open ? self.showPosition: self.hidePosition
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.frame.size = CGSize(width: 500, height: 500)
        view.center = hidePosition
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
        if let nextLevel = gameViewController.level?.nextLevel {
            gameViewController.level = nextLevel
        }
        closeMenu()
    }
    
    func playAgainAndDismiss() {
        CommandFactory.NativeClearCommand().execute()
        closeMenu()
    }
    
    deinit {
        println("MessageViewController is being deallocated")
    }

}
