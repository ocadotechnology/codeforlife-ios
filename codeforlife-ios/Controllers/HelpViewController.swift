//
//  HelpViewController.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 26/06/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import UIKit

class HelpViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var helpContentScrollView: UIScrollView!
    @IBOutlet weak var contextTextView: UITextView!
    @IBOutlet weak var dismissButton: UIButton!
    
    var hidePosition: CGPoint?
    var showPosition: CGPoint?
    
    var gameViewController: GameViewController? {
        didSet {
            showPosition = gameViewController!.view.center
            hidePosition = CGPointMake(
                self.view.center.x,
                gameViewController!.view.frame.height + gameViewController!.helpMessageFrame.height/2)
        }
    }
    
    var helpTitle: String? {
        didSet {
            titleLabel.text = helpTitle
        }
    }
    
    var context: String? {
        didSet {
            contextTextView.text = context
        }
    }
    
    var open = false {
        didSet {
            if open {
                UIView.animateWithDuration(0.5) {
                    self.view.center = self.gameViewController!.view.center
                }
            } else {
                UIView.animateWithDuration(0.5) {
                    self.view.center = CGPointMake(
                        self.view.center.x,
                        self.gameViewController!.view.frame.height + self.gameViewController!.helpMessageFrame.height/2)
                }
            }
        }
    }
    
    @IBAction func dismissMenu() {
        open = false
    }

}
