//
//  BlockTableViewController.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 25/06/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import UIKit

class BlockTableViewController: SubGameViewController, UITableViewDelegate, UITableViewDataSource {
    
    static let sharedInstance = StaticContext.storyboard.instantiateViewControllerWithIdentifier("BlockTableViewController") as! BlockTableViewController
    
    let CellReuseIdentifier = "Block"
    let frameOffset: CGFloat = 10
    let bottomOffset: CGFloat = 40
    
    @IBOutlet var tableView: BlockTableView!
    @IBOutlet var containerView: UIView!
    
    override var frame: CGRect {
        return CGRect(
            x: frameOffset,
            y: frameOffset,
            width: StaticContext.MainGameViewController!.view.frame.width*(1-StaticContext.MainGameViewController!.webViewPortion) - 2*frameOffset,
            height: StaticContext.MainGameViewController!.view.frame.height - 2*frameOffset - bottomOffset)
    }
    
    var blocks: [Block] = [Start()] {
        didSet {
            self.tableView.reloadData()
            let indexPath = NSIndexPath(forRow: blocks.count - 1, inSection: 0)
            tableView.scrollToRowAtIndexPath(indexPath, atScrollPosition: UITableViewScrollPosition.Bottom, animated: true)
        }
    }
    
    func clearBlocks() {
        blocks = [Start()]
    }
    
    func addBlock(newBlock: Block) {
        blocks.last?.nextBlock = newBlock
        blocks.append(newBlock)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        containerView.layer.cornerRadius = 10
        containerView.layer.masksToBounds = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        tableView.dataSource = self
        tableView.delegate = self
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return blocks.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
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
