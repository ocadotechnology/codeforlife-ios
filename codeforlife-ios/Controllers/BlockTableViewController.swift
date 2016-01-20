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
    
    private weak var selectedBlockly: UIBlocklyView? {
        willSet { self.selectedBlockly?.state = BlocklyUIState.Normal }
        didSet  { self.selectedBlockly?.state = BlocklyUIState.Selected }
    }
 
    private weak var incorrectBlockly: UIBlocklyView? {
        willSet { self.incorrectBlockly?.state = BlocklyUIState.Normal }
        didSet  { self.incorrectBlockly?.state = BlocklyUIState.Error }
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        
        blocklyGenerator.addBlocklyButton(CustomBlocklyFactory.createMoveForwardBlock)
        blocklyGenerator.addBlocklyButton(CustomBlocklyFactory.createTurnLeftBlock)
        blocklyGenerator.addBlocklyButton(CustomBlocklyFactory.createTurnRightBlock)
        blocklyGenerator.addBlocklyButton(CustomBlocklyFactory.createDeliverBlock)
    }
    
    override public func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        menuButton.backgroundColor = kC4LBlocklyForwardBlockColour
    }
    
    final func clearBlocks() {
        resetHighlightCellVariables()
        Workspace.getInstance().topBlocks.foreach({
            core in
            core.removeFromWorkspace()
        })
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
        Workspace.getInstance().topBlocks.getItemAtIndex(0)?.foreach({
            (blocklyCore) in
            switch blocklyCore.typeId {
            case 1: str += "\"move_forwards\","
            case 2: str += "\"turn_left\","
            case 3: str += "\"turn_right\","
            case 4: str += "\"deliver\","
            default: break
            }
        })
        str = Workspace.getInstance().topBlocks.getItemAtIndex(0)?.nextConnection?.targetConnection != nil ? str.substringToIndex(str.startIndex.advancedBy(str.characters.count-1)) + "])" : str + "])"
        gvcDelegate?.submitBlocks(str, completion: {print(str)})
    }
    
    final func highlightRow(row: Int) {
        var currentBlock = Workspace.getInstance().topBlocks.getItemAtIndex(0)
        for _ in 1...row {
            currentBlock = currentBlock?.nextBlockly
        }
        selectedBlockly = currentBlock?.blocklyView as? UIBlocklyView
    }
    
    final func highlightIncorrectBlockly(row: Int) {
        var currentBlock = Workspace.getInstance().topBlocks.getItemAtIndex(0)
        for _ in 1...row {
            currentBlock = currentBlock?.nextBlockly
        }
        incorrectBlockly = currentBlock?.blocklyView as? UIBlocklyView
    }
    
//    deinit { println("BlockTableViewController is being deallocated") }

}
