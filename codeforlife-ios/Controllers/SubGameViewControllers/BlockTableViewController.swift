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
    
    @IBOutlet weak var clearButton: GameViewButton!
    
    var recognizer: BlockTableViewPanGestureRecognizer?
    
    var blocks: [Block] = [Start()] {
        didSet {
            self.tableView.reloadData()
            let indexPath = NSIndexPath(forRow: blocks.count - 1, inSection: 0)
            tableView.scrollToRowAtIndexPath(indexPath, atScrollPosition: UITableViewScrollPosition.Bottom, animated: true)
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
    @IBAction func clear() {
        CommandFactory.WebViewClearCommand().execute()
        CommandFactory.NativeClearCommand().execute()
    }
    
    final func clearBlocks() {
        blocks.removeAll(keepCapacity: false)
        blocks.append(Start())
    }
    
    final func addBlock(newBlock: Block) {
        blocks.append(newBlock)
    }
    
    final func submitBlocks() {
        var str: String = "ocargo.animation.serializeAnimationQueue(["
        for block in blocks {
            str += block.type
        }
        str = str.substringToIndex(advance(str.startIndex, count(str)-1))
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
        cell.stepNumber.text = indexPath.row == 0 ? "" : "Step \(indexPath.row)"
        cell.blockDescription.text = block.description
        cell.containerView.backgroundColor = block.color
        return cell
    }
    
//    deinit { println("BlockTableViewController is being deallocated") }

}
