//
//  BlockTableViewController.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 25/06/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import UIKit

class BlockTableViewController: SubGameViewController, UITableViewDelegate, UITableViewDataSource {
    
    let CellReuseIdentifier = "Block"
    let frameOffset: CGFloat = 10
    let bottomOffset: CGFloat = 40
    
    @IBOutlet var tableView: BlockTableView!
    @IBOutlet var containerView: UIView!
    
    var startPosition: CGPoint?
    var selectedRow: Int?
    var originalX: CGFloat?
    
    var selectedBlock = 0 {
        didSet {
            if selectedBlock < blocks.count {
                if selectedBlock > 0 {
                    tableView.selectRowAtIndexPath(NSIndexPath(forRow: selectedBlock, inSection: 0), animated: false, scrollPosition: UITableViewScrollPosition.Top)
                }
            } else {
                selectedBlock = 0
            }
        }
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
//        blocks.last?.nextBlock = newBlock
        blocks.append(newBlock)
    }
    
    func submitBlocks() {
        for block in blocks {
            block.submit()
        }
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
        
        var recognizer = UIPanGestureRecognizer(target: self, action: Selector("panGesture:"))
        tableView.addGestureRecognizer(recognizer)
    }
    
    func panGesture (sender:UIPanGestureRecognizer) {
        if (sender.state == UIGestureRecognizerState.Began) {
            startPosition = sender.locationInView(self.tableView)
            if let indexPath = tableView.indexPathForRowAtPoint(startPosition!),
                cell = tableView.cellForRowAtIndexPath(indexPath) {
                originalX = cell.center.x
                selectedRow = indexPath.row
            }
        } else if (sender.state == UIGestureRecognizerState.Ended) {
            let stopPosition = sender.locationInView(self.tableView)
            let dx = startPosition!.x - stopPosition.x
            if dx > 200 && selectedRow != nil{
                blocks.removeAtIndex(selectedRow!)
            } else {
                let indexPath = tableView.indexPathForRowAtPoint(startPosition!)
                let cell = tableView.cellForRowAtIndexPath(indexPath!)
                cell!.center.x = originalX!
            }
        } else if (sender.state == UIGestureRecognizerState.Changed) {
            if let indexPath = tableView.indexPathForRowAtPoint(startPosition!),
                    cell = tableView.cellForRowAtIndexPath(indexPath) {
                let translation = sender.translationInView(self.tableView)
                println((translation.x, originalX! + translation.x - originalX!, originalX! + translation.x > originalX!))
                if originalX! + translation.x < originalX! {
                    cell.center.x = originalX! + translation.x
                }
            }
        }
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
        cell.selectionStyle = .None
        cell.stepNumber.text = indexPath.row == 0 ? "" : "Step \(indexPath.row)"
        cell.blockDescription.text = block.description
        cell.containerView.backgroundColor = block.color
        return cell
    }
    
}
