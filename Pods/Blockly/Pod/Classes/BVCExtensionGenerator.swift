//
//  BVCExtensionGenerator.swift
//  Pods
//
//  Created by Joey Chan on 27/08/2015.
//
//

import Foundation

extension BlocklyViewController {
    
    func setupBlocklyGenerator() {
        self.addChildViewController(blocklyGenerator)
        self.view.insertSubview(blocklyGenerator.view, belowSubview: menuButton)
        blocklyGenerator.view.frame = CGRect(origin: view.frame.origin, size: CGSizeMake(BlocklyGeneratorWidth, view.frame.height))
        blocklyGenerator.view.layer.zPosition = 0.9
        blocklyGenerator.view.frame.origin = self.view.frame.origin - CGPointMake(self.view.frame.width, 0)
        blocklyGenerator.didMoveToParentViewController(self)
    }
    
}