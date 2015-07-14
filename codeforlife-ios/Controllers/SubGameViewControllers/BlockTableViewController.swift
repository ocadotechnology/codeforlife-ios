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
//            block.submit()
            block.submitMock()
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
        self.tableView.panGestureRecognizer.minimumNumberOfTouches = 2
        self.tableView.panGestureRecognizer.maximumNumberOfTouches = 2
        
        var recognizer = UIPanGestureRecognizer(target: self, action: Selector("panGesture:"))
        recognizer.minimumNumberOfTouches = 1
        recognizer.maximumNumberOfTouches = 1
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
    
    private func resetPanGestureVariables() {
        selectedCell?.layer.zPosition = 0
        startPosition = nil
        selectedRow = nil
        selectedCell = nil
        originalPosition = nil
        verticalMode = false
        horizontalMode = false
    }
    func panGesture (sender:UIPanGestureRecognizer) {
        if (sender.state == UIGestureRecognizerState.Began) {
            recordStartPosition(sender.locationInView(self.tableView))
            
        } else if (sender.state == UIGestureRecognizerState.Ended) {
            let stopPosition = sender.locationInView(self.tableView)
            let indexPath = tableView.indexPathForRowAtPoint(stopPosition)
            let dx = startPosition!.x - stopPosition.x
            if selectedCell != nil && selectedRow != nil {
                if horizontalMode && dx > 150 {
                    blocks.removeAtIndex(selectedRow!)
                } else if verticalMode {
                    let destinationRow = Int(round(((stopPosition.y - cellHeight/2) / cellHeight) - 0.5))
                    repositionBlock(selectedRow!, to: max(1, min(destinationRow, blocks.count-1)))
                } else if originalPosition != nil {
                    selectedCell?.center = originalPosition!
                }
            }
            resetPanGestureVariables()
        } else if (sender.state == UIGestureRecognizerState.Changed) && selectedCell != nil {
            let translation = sender.translationInView(self.tableView)
                    
            if horizontalMode {
                selectedCell?.center.x = originalPosition!.x + translation.x
            } else if verticalMode {
                selectedCell?.center.y = originalPosition!.y + translation.y
            }
            
            let leftSwipeDetected = originalPosition!.x + translation.x + 10 < originalPosition!.x
            let verticalSwipeDetected = originalPosition!.y + translation.y - 10 > originalPosition!.y
                                        || originalPosition!.y + translation.y + 10 < originalPosition!.y
            if leftSwipeDetected && !verticalMode {
                horizontalMode = true
            } else if verticalSwipeDetected && !horizontalMode {
                verticalMode = true
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
                selectedCell?.layer.zPosition = 1
                originalPosition = selectedCell?.center
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
