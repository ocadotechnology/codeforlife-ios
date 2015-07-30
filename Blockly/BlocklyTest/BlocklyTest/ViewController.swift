//
//  ViewController.swift
//  BlocklyTest
//
//  Created by Joey Chan on 28/07/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import UIKit
import SpriteKit
import Blockly

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = SKView()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        let bp = BlocklyScene(size: view.frame.size)
        let blocklyView = self.view as! SKView
        blocklyView.showsFPS = true
        blocklyView.showsNodeCount = true
        blocklyView.presentScene(bp)
        println(blocklyView.scene)
        bp.addHead(StartBlock(CGPointMake(500, 500)))
        bp.addBlockly(NormalBlock(CGPointMake(200, 200)))
        bp.addBlockly(NormalBlock(CGPointMake(300, 300)))
        bp.addBlockly(ConditionalBlock(CGPointMake(400, 400)))
        for blockly in IfThenBlock(CGPointMake(600, 600)) {
            bp.addBlockly(blockly)
        }
    }
    
    private func StartBlock(pos: CGPoint) -> Blockly {
        let blockly = Blockly.build({
            $0.position = pos
            $0.color = UIColor.greenColor()
            $0.prevSnappingEnabled = false
        })
        return blockly
    }
    
    private func NormalBlock(pos: CGPoint) -> Blockly {
        let blockly = Blockly.build({
            $0.position = pos
            $0.color = UIColor.blueColor()
        })
        return blockly
    }
    
    private func ConditionalBlock(pos: CGPoint) -> Blockly {
        let blockly = Blockly.build({
            $0.originalSize.height /= 2
            $0.position = pos
            $0.color = UIColor.redColor()
            $0.parentSnappingEnabled = true
        })
        return blockly
    }
    
    private func SisteBlock(pos: CGPoint) -> Blockly {
        let blockly = Blockly.build({
            $0.originalSize.height /= 2
            $0.position = pos
            $0.color = UIColor.brownColor()
            $0.prevSnappingEnabled = false
            $0.nextSnappingEnabled = false
        })
        return blockly
    }
    
    private func IfThenBlock(pos: CGPoint) -> [Blockly] {
        let ifBlockly = Blockly.build({
            $0.position = pos
            $0.originalSize.height /= 2
            $0.color = UIColor.blackColor()
            $0.parentSnappingEnabled = true
        })
        let thenBlockly = Blockly.build({
            $0.prev = ifBlockly
            $0.originalSize.width /= 4
            $0.originalSize.height /= 2
            $0.color = UIColor.yellowColor()
            $0.lockPrev = true
            $0.snapToNeighbour()
        })
        let endBlockly = Blockly.build({
            $0.size.height /= 2
            $0.prev = thenBlockly
            $0.color = UIColor.grayColor()
            $0.lockPrev = true
            $0.snapToNeighbour()
        })
        return [ifBlockly, thenBlockly, endBlockly]
    }

}
