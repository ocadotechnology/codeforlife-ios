//
//  BlockTableViewController.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 25/06/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import UIKit
import Blockly

class BlockTableViewController: BlocklyViewController {

    let CellReuseIdentifier = "Block"
    let TableViewWidth: CGFloat = 250
    let ToggleBlocklyTableAnimationDuration: NSTimeInterval = 0.5
    
    @IBOutlet weak var containerView: UIView!
    
    unowned var gameViewController: GameViewController {
        return parentViewController! as! GameViewController
    }
    
    private weak var selectedBlockly: Blockly? {
        willSet { self.selectedBlockly?.isSelected = false }
        didSet  { self.selectedBlockly?.isSelected = true }
    }
 
    private weak var incorrectBlockly: Blockly? {
        willSet { self.incorrectBlockly?.isError = false }
        didSet  { self.incorrectBlockly?.isError = true }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        menuButton.setImage(UIImage(named: "button_blockly_generator"), forState: UIControlState.Normal)
        menuButton.backgroundColor = UIColor.clearColor()
        
        blocklyGenerator.addBlocklyButton(BlocklyFactory.createMoveForwardBlock)
        blocklyGenerator.addBlocklyButton(BlocklyFactory.createTurnLeftBlock)
        blocklyGenerator.addBlocklyButton(BlocklyFactory.createTurnRightBlock)
        blocklyGenerator.addBlocklyButton(BlocklyFactory.createDeliverBlock)
    }
    
    final func recalculateVanPosition() {
        gameViewController.gameMapViewController?.map?.resetMap()
        gameViewController.gameMapViewController?.map?.van.reset()
        var currentBlock = Workspace.topBlocks.getItemAtIndex(0)
        while currentBlock?.nextConnection?.targetConnection != nil {
            executeBlocklyAnimation(currentBlock!.typeId, animated: false, completion: nil)
            currentBlock = currentBlock?.nextConnection?.targetConnection?.sourceBlock
        }
    }
    
    private func executeBlocklyAnimation(typeId: Int, animated: Bool, completion: (() -> Void)?) {
        let van = SharedContext.MainGameViewController?.gameMapViewController?.map?.van
        switch typeId {
        case 1:
            ActionFactory.createAction("DisableDirectDrive").execute()
            van?.moveForward(animated: animated, completion: {
                ActionFactory.createAction("EnableDirectDrive").execute()
                completion?()
            })
        case 2:
            ActionFactory.createAction("DisableDirectDrive").execute()
            van?.turnLeft(animated: animated, completion: {
                ActionFactory.createAction("EnableDirectDrive").execute()
                completion?()
            })
        case 3:
            ActionFactory.createAction("DisableDirectDrive").execute()
            van?.turnRight(animated: animated, completion: {
                ActionFactory.createAction("EnableDirectDrive").execute()
                completion?()
            })
        case 4:
            van?.deliver(animated: animated, completion: completion)
        default:
            completion?()
        }
    }
    
    final func clearBlocks() {
        resetHighlightCellVariables()
        Workspace.topBlocks.foreach({(core) in core.blockly?.removeFromWorkspace(true)})
        let startBlock = BlocklyFactory.createStartBlock()
        addBlockly(startBlock)
        startBlock.center = CGPointMake(view.center.x, 100)
    }
    
    final func resetHighlightCellVariables() {
        selectedBlockly = nil
        incorrectBlockly = nil
    }
    
    final func submitBlocks() {
        var str = "ocargo.animation.serializeAnimationQueue(["
        Workspace.topBlocks.getItemAtIndex(0)?.foreach({
            (blocklyCore) in
            switch blocklyCore.typeId {
            case 1: str += "\"move_forwards\","
            case 2: str += "\"turn_left\","
            case 3: str += "\"turn_right\","
            case 4: str += "\"deliver\","
            default: break
            }
        })
        str = Workspace.topBlocks.getItemAtIndex(0)?.nextConnection?.targetConnection != nil ? str.substringToIndex(advance(str.startIndex, count(str)-1)) + "])" : str + "])"
        println(str)
        gameViewController.runJavaScript(str)
    }
    
    final func highlightRow(row: Int) {
        var currentBlock = Workspace.topBlocks.getItemAtIndex(0)
        for i in 1...row {
            currentBlock = currentBlock?.nextConnection?.targetConnection?.sourceBlock
        }
        selectedBlockly = currentBlock?.blockly
    }
    
    final func highlightIncorrectBlockly(row: Int) {
        var currentBlock = Workspace.topBlocks.getItemAtIndex(0)
        for i in 1...row {
            currentBlock = currentBlock?.nextConnection?.targetConnection?.sourceBlock
        }
        incorrectBlockly = currentBlock?.blockly
    }
    
    
//    deinit { println("BlockTableViewController is being deallocated") }

}
