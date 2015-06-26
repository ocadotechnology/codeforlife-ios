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
    let offset = 10 as CGFloat
    
    var gameViewController: GameViewController?
    
    var frame: CGRect {
        return CGRect(
            x: offset,
            y: offset,
            width: self.gameViewController!.view.frame.width*(1-self.gameViewController!.webViewPortion) - 2*offset,
            height: self.gameViewController!.view.frame.height - 2*offset - 40)
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
            cell.containerView.backgroundColor = UIColor(red: 208/255.0, green: 112/255.0, blue: 112/255.0, alpha: 1)       // #D07070
        } else if indexPath.row % 2 == 0 {
            cell.containerView.backgroundColor = UIColor(red: 0/255.0, green: 176/255.0, blue: 208/255.0, alpha: 1)         // #00B0D0
        } else {
            cell.containerView.backgroundColor = UIColor(red: 7*16/255.0, green: 12*16/255.0, blue: 15*16/255.0, alpha: 1)  // #70C0F0
        }
        
        return cell
    }

}
