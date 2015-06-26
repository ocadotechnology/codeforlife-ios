//
//  HelpViewController.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 26/06/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import UIKit

class HelpMessageViewController: UIViewController {
    
    let helpMessageFrame = CGSize(width: 500, height: 500)
    
    let containerViewCornerRadius: CGFloat = 50
    let containerViewBorderWidth: CGFloat = 10
    let messageButtonBorderWidth: CGFloat = 5
    let messageButtonCornerRadius: CGFloat = 25

    @IBOutlet var containerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var helpContentScrollView: UIScrollView!
    @IBOutlet weak var contextTextView: UITextView!
    @IBOutlet weak var messageButton: UIButton!
    
    var hidePosition: CGPoint {
        return CGPointMake(
            self.view.center.x,
            gameViewController!.view.frame.height + helpMessageFrame.height/2)
    }
    
    var showPosition: CGPoint {
        return gameViewController!.view.center
    }
    
    var frame: CGRect {
        return CGRect(
            x: self.gameViewController!.view.center.x - helpMessageFrame.width/2,
            y: self.gameViewController!.view.frame.height,
            width: helpMessageFrame.width,
            height: helpMessageFrame.height)
    }
    
    var gameViewController: GameViewController?
    
    var message: Message? {
        didSet {
            titleLabel.text = message!.title
            subtitleLabel.text = message!.subtitle
            contextTextView.text = message!.context
            messageButton.titleLabel!.text = message!.buttonText
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
        containerView.layer.cornerRadius = containerViewCornerRadius
        containerView.layer.masksToBounds = true
        containerView.layer.borderColor = kC4LMessageBorderColour.CGColor
        containerView.layer.borderWidth = containerViewBorderWidth
        messageButton.layer.cornerRadius = messageButtonCornerRadius
        messageButton.layer.masksToBounds = true
        messageButton.layer.borderWidth = messageButtonBorderWidth
        messageButton.layer.borderColor = kC4lMessageButtonBorderColour.CGColor
        messageButton.backgroundColor = kC4lMessageButtonBackgroundColour
    }
    
    @IBAction func dismissMenu() {
        if let action = message?.action {
            action()
        }
    }

}
