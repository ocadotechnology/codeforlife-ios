//
//  BlockTableViewController.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 25/06/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import UIKit
import Blockly

public class BlockTableViewController: BlocklyViewController {
    
    let ToggleBlocklyTableAnimationDuration: NSTimeInterval = 0.5
    
    let CellReuseIdentifier = "Block"
    let BlocklyGeneratorButtonImageName = "button_blockly_generator"
    let JavascriptInitialContent = "ocargo.animation.serializeAnimationQueue(["
    
    public weak var gvcDelegate: GameViewControllerDelegate?
    
    @IBOutlet weak var containerView: UIView!
    
    private weak var selectedBlockly: Blockly? {
        willSet { self.selectedBlockly?.isSelected = false }
        didSet  { self.selectedBlockly?.isSelected = true }
    }
 
    private weak var incorrectBlockly: Blockly? {
        willSet { self.incorrectBlockly?.isError = false }
        didSet  { self.incorrectBlockly?.isError = true }
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        menuButton.setImage(UIImage(named: BlocklyGeneratorButtonImageName), forState: UIControlState.Normal)
        menuButton.backgroundColor = UIColor.clearColor()
        
        blocklyGenerator.addBlocklyButton(BlocklyFactory.createMoveForwardBlock)
        blocklyGenerator.addBlocklyButton(BlocklyFactory.createTurnLeftBlock)
        blocklyGenerator.addBlocklyButton(BlocklyFactory.createTurnRightBlock)
        blocklyGenerator.addBlocklyButton(BlocklyFactory.createDeliverBlock)
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
        var str = JavascriptInitialContent
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
        gvcDelegate?.submitBlocks(str, completion: {println(str)})
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
