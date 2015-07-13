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
    
    @IBOutlet weak var tableView: BlockTableView!
    @IBOutlet weak var containerView: UIView!
    
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
        blocks.removeAll(keepCapacity: false)
        blocks.append(Start())
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
    
    func repositionBlock(from: Int, to: Int) {
        var block = blocks.removeAtIndex(from)
        blocks.splice([block], atIndex: to)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        containerView.layer.cornerRadius = 10
        containerView.layer.masksToBounds = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var recognizer = UIPanGestureRecognizer(target: self, action: Selector("panGesture:"))
        tableView.addGestureRecognizer(recognizer)
        
        tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        tableView.dataSource = self
        tableView.delegate = self
        
    }
    
    var startPosition: CGPoint?
    var selectedRow: Int?
    weak var selectedCell: UITableViewCell?
    var originalPosition: CGPoint?
    var verticalMode = false
    var horizontalMode = false
    let cellHeight: CGFloat = 90
    func panGesture (sender:UIPanGestureRecognizer) {
        if (sender.state == UIGestureRecognizerState.Began) {
            recordStartPosition(sender.locationInView(self.tableView))
        } else if (sender.state == UIGestureRecognizerState.Ended) {
            let stopPosition = sender.locationInView(self.tableView)
            let indexPath = tableView.indexPathForRowAtPoint(stopPosition)
            let dx = startPosition!.x - stopPosition.x
            if horizontalMode && dx > 150 && selectedCell != nil && selectedRow != nil {
                blocks.removeAtIndex(selectedRow!)
            } else if verticalMode {
                handleVerticalAction(stopPosition)
            } else {
                if let indexPath = tableView.indexPathForRowAtPoint(startPosition!) {
                    let cell = tableView.cellForRowAtIndexPath(indexPath)
                    cell!.center = originalPosition!
                }
            }
            verticalMode = false
            horizontalMode = false
        } else if (sender.state == UIGestureRecognizerState.Changed) {
            if let indexPath = tableView.indexPathForRowAtPoint(startPosition!),
                    cell = tableView.cellForRowAtIndexPath(indexPath) {
                let translation = sender.translationInView(self.tableView)
                if originalPosition!.x + translation.x + 10 < originalPosition!.x && indexPath.row != 0  && !verticalMode {
                    horizontalMode = true
                    cell.center.x = originalPosition!.x + translation.x
                } else if indexPath.row != 0 && !horizontalMode &&
                        (originalPosition!.y + translation.y - 10 > originalPosition!.y ||
                         originalPosition!.y + translation.y + 10 < originalPosition!.y){
                    verticalMode = true
                    cell.center.y = originalPosition!.y + translation.y
                }
            }
        }
    }
    
    // Record StartPosition and Selected Cell
    private func recordStartPosition(position: CGPoint) {
        startPosition = position
        if let indexPath = tableView.indexPathForRowAtPoint(startPosition!) {
            if indexPath.row != 0 {
                selectedRow = indexPath.row
                selectedCell = tableView.cellForRowAtIndexPath(indexPath)
                originalPosition = selectedCell?.center
            }
        }
    }
    
    private func handleVerticalAction(stopPosition: CGPoint) {
        let row = Int(round(((stopPosition.y - cellHeight/2) / cellHeight) - 0.5))
        repositionBlock(selectedRow!, to: min(row, blocks.count))
//        if let indexPath = tableView.indexPathForRowAtPoint(startPosition!) {
//            let cell = tableView.cellForRowAtIndexPath(indexPath)
//            cell!.center = originalPosition!
//        }
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return blocks.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(CellReuseIdentifier, forIndexPath: indexPath) as! BlockTableViewCell
        unowned var block = blocks[indexPath.row]
        cell.selectionStyle = .None
        cell.stepNumber.text = indexPath.row == 0 ? "" : "Step \(indexPath.row)"
        cell.blockDescription.text = block.description
        cell.containerView.backgroundColor = block.color
        return cell
    }
    
    deinit {
        blocks.removeAll(keepCapacity: false)
        println("BlockTableViewController is being deallocated")
    }
    
}
