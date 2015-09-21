//
//  BlocklyVCExtensionInterpretation.swift
//  Pods
//
//  Created by Joey Chan on 27/08/2015.
//
//

import UIKit
import Foundation

extension BlocklyViewController {

    func setupInterpretButton() {
        let interpretButton = UIButton()
        view.addSubview(interpretButton)
        interpretButton.autoresizingMask = UIViewAutoresizing.FlexibleLeftMargin | UIViewAutoresizing.FlexibleBottomMargin
        interpretButton.backgroundColor = UIColor.blackColor()
        interpretButton.frame = CGRect(origin: CGPointMake(view.frame.width-100, 0), size: CGSizeMake(100, 100))
        interpretButton.addTarget(self, action: "interpret", forControlEvents: UIControlEvents.TouchDown)
    }
    
    func interpret() {
        let startBlock = Workspace.getInstance().topBlocks.getItemAtIndex(0)
        BlocklyInterpreter().interpret(startBlock)
    }
    
}