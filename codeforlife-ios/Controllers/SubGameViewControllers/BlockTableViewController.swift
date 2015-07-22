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
    let TableViewWidth: CGFloat = 250
    let ToggleBlocklyTableAnimationDuration: NSTimeInterval = 0.5
    
    @IBOutlet weak var tableView: BlockTableView!
    @IBOutlet weak var containerView: UIView!
    
    var recognizer: BlockTableViewPanGestureRecognizer?
    
    var blocks: [Block] = [Start()] {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    var currentSelectedCell = 0 {
        willSet {
            if currentSelectedCell > 0 && currentSelectedCell <= blocks.count {
                tableView.cellForRowAtIndexPath(NSIndexPath(forRow: currentSelectedCell, inSection: 0))?.backgroundColor = UIColor.clearColor()
            }
        }
        didSet {
            if currentSelectedCell > 0 && currentSelectedCell <= blocks.count {
                tableView.cellForRowAtIndexPath(NSIndexPath(forRow: currentSelectedCell, inSection: 0))?.backgroundColor = UIColor.yellowColor()
            }
        }
    }
    
    var incorrectCell = 0 {
        willSet {
            if incorrectCell > 0 && incorrectCell <= blocks.count {
                tableView.cellForRowAtIndexPath(NSIndexPath(forRow: incorrectCell, inSection: 0))?.backgroundColor = UIColor.clearColor()
            }
        }
        didSet {
            if incorrectCell > 0 && incorrectCell <= blocks.count {
                tableView.cellForRowAtIndexPath(NSIndexPath(forRow: incorrectCell, inSection: 0))?.backgroundColor = UIColor.redColor()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Disable one finger scroll and enable two finger scroll
        self.tableView.panGestureRecognizer.minimumNumberOfTouches = 2
        self.tableView.panGestureRecognizer.maximumNumberOfTouches = 2
        
        // Add Pan Gesture Recognizer
        recognizer = BlockTableViewPanGestureRecognizer(viewController: self)
        tableView.addGestureRecognizer(recognizer!)
        
        tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    final func recalculateVanPosition() {
        gameViewController.gameMapViewController?.map?.resetMap()
        gameViewController.gameMapViewController?.map?.van.reset()
        for block in blocks {
            block.executeBlockAction()
        }
        gameViewController.gameMapViewController?.map?.van.updatePosition()
    }
    
    final func clearBlocks() {
        resetHighlightCellVariables()
        blocks.removeAll(keepCapacity: false)
        blocks.append(Start())
    }
    
    final func resetHighlightCellVariables() {
        currentSelectedCell = 0
        incorrectCell = 0
    }
    
    final func addBlock(newBlock: Block) {
        blocks.append(newBlock)
        let indexPath = NSIndexPath(forRow: blocks.count - 1, inSection: 0)
        tableView.scrollToRowAtIndexPath(indexPath, atScrollPosition: UITableViewScrollPosition.Bottom, animated: true)
    }
    
    final func submitBlocks() {
        var str: String = "ocargo.animation.serializeAnimationQueue(["
        for block in blocks {
            str += block.type
        }
        if blocks.count > 1 {
            str = str.substringToIndex(advance(str.startIndex, count(str)-1))
        }
        str += "])"
        println(str)
        gameViewController.runJavaScript(str)
    }
    
    final func highlightRow(row: Int) {
        if row < blocks.count {
            tableView.selectRowAtIndexPath(NSIndexPath(forRow: row, inSection: 0), animated: false, scrollPosition: UITableViewScrollPosition.Top)
        }
    }
    
    final func handlePanGesture(sender: BlockTableViewPanGestureRecognizer) {
        recognizer?.handlePanGesture(sender)
    }
    
    final func goToTopBlock() {
        let indexPath = NSIndexPath(forRow: 0, inSection: 0)
        tableView.scrollToRowAtIndexPath(indexPath, atScrollPosition: UITableViewScrollPosition.Top, animated: true)
    }

    
    /*********************
     * TableViewDelegate *
     *********************/
    
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
        cell.stepNumber.text = ""
//        cell.stepNumber.text = indexPath.row == 0 ? "" : "Step \(indexPath.row)"
        cell.blockDescription.text = block.description
        cell.containerView.backgroundColor = block.color
        return cell
    }
    
//    deinit { println("BlockTableViewController is being deallocated") }

}
