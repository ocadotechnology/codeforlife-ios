//
//  BlockTableViewController.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 25/06/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import UIKit

class BlockTableViewController: UITableViewController {
    
    let CellReuseIdentifier = "Block"
    let frameOffset: CGFloat = 10
    let bottomOffset: CGFloat = 40
    
    var gameViewController: GameViewController?
    
    var frame: CGRect {
        return CGRect(
            x: frameOffset,
            y: frameOffset,
            width: self.gameViewController!.view.frame.width*(1-self.gameViewController!.webViewPortion) - 2*frameOffset,
            height: self.gameViewController!.view.frame.height - 2*frameOffset - bottomOffset)
    }
    
    var blocks: [Block] = [Start()] {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    func clearBlocks() {
        blocks = [Start()]
    }
    
    func addBlock(newBlock: Block) {
        blocks.append(newBlock)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorStyle = UITableViewCellSeparatorStyle.None
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return blocks.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(CellReuseIdentifier, forIndexPath: indexPath) as! BlockTableViewCell
        var block = blocks[indexPath.row]
        cell.stepNumber.text = indexPath.row == 0 ? "" : "Step \(indexPath.row)"
        cell.blockDescription.text = block.description
        
        if indexPath.row == 0 {
            cell.containerView.backgroundColor = kC4LBlocklyStartBlockColour
        } else if indexPath.row % 2 == 0 {
            cell.containerView.backgroundColor = kC4lBlocklyEvenBlockColour
        } else {
            cell.containerView.backgroundColor = kC4lBlocklyOddBlockColour
        }
        
        return cell
    }

}
