//
//  HighlightAnimation.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 17/07/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import SpriteKit
import Foundation

class HighlightAnimation: Animation {
    
    let blockId: Int
    
    init(blockId: Int) {
        self.blockId = blockId
    }
    
    override func executeAnimation(completion: (() -> Void)? = nil) {
        println("Highlight Cell: \(blockId)")
        let indexPath = NSIndexPath(forRow: blockId, inSection: 0)
        let viewController = SharedContext.MainGameViewController?.blockTableViewController
        viewController?.tableView.scrollToRowAtIndexPath(indexPath, atScrollPosition: UITableViewScrollPosition.Middle, animated: true)
        viewController?.currentSelectedCell = blockId
        completion?()
    }
}