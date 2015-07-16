//
//  HelpViewController.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 26/06/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import UIKit

class MessageViewController: UIViewController {
    
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
            SharedContext.MainGameViewController!.view.center.x,
            SharedContext.MainGameViewController!.view.frame.height + messageFrame.height/2)
    }
    
    var showPosition: CGPoint {
        return SharedContext.MainGameViewController!.view.center
    }
    
    weak var message: Message? {
        didSet {
            self.view = message?.view
        }
    }
    
    @IBOutlet weak var containerView: UIView!
    
    var open = false {
        didSet {
            UIView.animateWithDuration(0.5, animations: {
                self.view.center = self.open ? self.showPosition: self.hidePosition}) { [unowned self] (animated) -> Void in
                    if !self.open {
                        self.willMoveToParentViewController(nil)
                        self.view.removeFromSuperview()
                        self.removeFromParentViewController()
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        modalPresentationStyle = UIModalPresentationStyle.OverCurrentContext
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
        if let nextLevel = SharedContext.MainGameViewController!.level?.nextLevel {
            SharedContext.MainGameViewController?.level = nextLevel
        }
        closeMenu()
    }
    
    func playAgainAndDismiss() {
        CommandFactory.NativeClearCommand().execute()
        closeMenu()
    }
    
//    deinit { println("MessageViewController is being deallocated") }

}
