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
    
    let helpMessageFrame = CGSize(width: 500, height: 500)
    
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
            UIView.animateWithDuration(0.5) {
                self.view.center = self.open ? self.showPosition: self.hidePosition
            }
        }
    }
    
    @IBAction func dismissMenu() {
        open = false
    }

}
