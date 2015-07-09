//
//  Blocks.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 25/06/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import UIKit
import Foundation

class Block {
    
    var nextBlock: Block?
    var description: String
    var color: UIColor
    
    init(description: String, color: UIColor) {
        self.description = description
        self.color = color
    }
    
    // Not in use yet
    func executeBlockAction(player: MovableGameObject, completion: (() -> Void)? = nil) {
        if player.crashed {
            CommandFactory.NativeShowFailMessageCommand().execute()
        } else {
            StaticContext.MainGameViewController?.blockTableViewController.selectedBlock++
            completion?()
        }
    }
    
    // Not in use yet
    func executeBlockChainAction(player: MovableGameObject, completion: (() -> Void)? = nil) {
        self.executeBlockAction(player) {
            if self.nextBlock != nil {
                self.nextBlock?.executeBlockChainAction(player, completion: completion)
            } else {
                player.deliver {
                    CommandFactory.NativeShowResultCommand().execute()
                }
                completion?()
            }
        }
    }
    
    func submit() {
        
    }
}