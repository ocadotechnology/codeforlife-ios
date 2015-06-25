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
    
    var blocks = [Block]() {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    func clearBlocks() {
        blocks = [Block]()
    }
    
    func addBlock(newBlock: Block) {
        blocks.append(newBlock)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
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
        cell.stepNumber.text =  "Step \(indexPath.row + 1)"
        cell.blockDescription.text = block.description
        return cell
    }

}
