//
//  BlockTableViewPanGestureRecognizer.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 15/07/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import UIKit
import Foundation

class BlockTableViewPanGestureRecognizer: UIPanGestureRecognizer {
    
    unowned var viewController: BlockTableViewController
    
    weak var selectedCell: UITableViewCell?
    
    var editable = true             // Gestures will only be recognized when true
    var verticalMode = false        // Blocks are allowed to be reordered when true
    var horizontalMode = false      // Blocks are allowed to be removed when true
    
    var originalPosition: CGPoint?  // The original center of the selected cell if one exists
    var selectedRow = 0             // Index of the selected cell, 0 if one doesn't exist
    var lastSelectedRow = 0         // Index of the last visited cell, 0 if one doesn't exist
    
    let animationDuration: NSTimeInterval = 0.5             // Duration of row animations
    let cellSize = CGSizeMake(250, 90)                      // Size of BlockTableViewCell
    let lowerBoundConsideredAsHorizontalSwipe:CGFloat = 150 // Lower bound of value to be considered
                                                            // as a horizontaol swipe
    
    // Z Position Priority
    let highZPosition   : CGFloat = 1
    let mediumZPosition : CGFloat = 0.8
    let lowZPosition    : CGFloat = 0
    
    var isSelectedCellValid: Bool {
        return selectedCell != nil && originalPosition != nil
    }
    
    init(viewController: BlockTableViewController) {
        self.viewController = viewController
        super.init(target: viewController, action: Selector("handlePanGesture:"))
        self.minimumNumberOfTouches = 1
        self.maximumNumberOfTouches = 1
    }
    
    func handlePanGesture(sender:UIPanGestureRecognizer) {
        
        let translation = sender.translationInView(viewController.tableView)
        let position = sender.locationInView(viewController.tableView)
        
        if editable {
            switch sender.state {
            case UIGestureRecognizerState.Began:
                recordStartPosition(sender.locationInView(viewController.tableView))
                
            case UIGestureRecognizerState.Changed:
                if isSelectedCellValid {
                    updateSelectedCellPosition(translation)
                    updateMode(translation)
                    animateRowChange()
                }
            case UIGestureRecognizerState.Ended:
                if isSelectedCellValid {
                    if horizontalMode && translation.x < -lowerBoundConsideredAsHorizontalSwipe {
                        animateRowChangeBeforeBlockRemoval()
                        removeBlockWithAnimation()
                    } else if verticalMode {
                        let currentRow = getCurrentRow()
                        repositionBlockWithAnimation(from: selectedRow, to: currentRow)
                    } else {
                        resetSelectedCellPosition()
                    }
                }
                resetPanGestureVariables()
                
            default:
                break
            }
        }
    }
    
    private func resetPanGestureVariables() {
        lastSelectedRow = 0
        selectedRow = 0
        selectedCell = nil
        originalPosition = nil
        verticalMode = false
        horizontalMode = false
    }
    
    /// Move selected cell back to its original position
    private func resetSelectedCellPosition() {
        selectedCell?.center = originalPosition!
    }
    
    /// Animate the row change affected by change in position of the selected cell
    private func animateRowChange() {
        let currentRow = getCurrentRow()
        if lastSelectedRow != currentRow {
            repositionBlockAnimations(startRow: selectedRow, endRow: currentRow)
            lastSelectedRow = currentRow
        }
    }
    
    /// Change the position of the selected cell during pan gesture
    private func updateSelectedCellPosition(translation: CGPoint) {
        selectedCell!.layer.zPosition = highZPosition
        if horizontalMode {
            selectedCell!.center.x = originalPosition!.x + translation.x
        } else if verticalMode {
            selectedCell!.center.y = originalPosition!.y + translation.y
        }
    }
    
    /// Assign HorizontalMode or VerticalMode if swipe is detected
    private func updateMode(translation: CGPoint) {
        let leftSwipeDetected = originalPosition!.x + translation.x + 10 < originalPosition!.x
        let verticalSwipeDetected = originalPosition!.y + translation.y - 10 > originalPosition!.y
            || originalPosition!.y + translation.y + 10 < originalPosition!.y
        horizontalMode = horizontalMode || leftSwipeDetected && !verticalMode
        verticalMode = verticalMode   || verticalSwipeDetected && !horizontalMode
    }
    
    /// Record StartPosition and Selected Cell
    private func recordStartPosition(position: CGPoint) {
        if let indexPath = viewController.tableView.indexPathForRowAtPoint(position) {
            if indexPath.row != 0 {
                lastSelectedRow = indexPath.row
                selectedRow = indexPath.row
                selectedCell = viewController.tableView.cellForRowAtIndexPath(indexPath)
                selectedCell?.layer.zPosition = highZPosition
                originalPosition = selectedCell?.center
            }
        }
    }
    
    /// Return the index of the row which the selected cell is currently in
    private func getCurrentRow() -> Int {
        let translation = selectedCell!.center.y - originalPosition!.y
        if abs(translation) > cellSize.height {
            let sgn = translation > 0 ? 1 : -1
            let absoluteIndexChange = Int(floor((abs(translation) - cellSize.height)/cellSize.height)) + 1
            let currentIndex = selectedRow + sgn * absoluteIndexChange
            return min(viewController.blocks.count - 1, max(1, currentIndex))
        } else {
            return selectedRow
        }
    }
    
    /// Animate the reposition of other blocks when certain block is repositioned.
    private func repositionBlockAnimations(#startRow: Int, endRow: Int) {
        for i in 1 ... viewController.blocks.count-1 {  // Update all blocks' position
            if i != startRow {                          // Except the block which is being repositioned
                let minRow = min(startRow, endRow) + (startRow < endRow ? 1 : 0)
                let maxRow = max(startRow, endRow) - (startRow > endRow ? 1 : 0)
                let indexPath = NSIndexPath(forRow: i, inSection: 0)
                let cell = self.viewController.tableView.cellForRowAtIndexPath(indexPath)
                cell?.layer.zPosition = mediumZPosition
                
                var newCellIndex = i
                if minRow ... maxRow ~= i {
                    newCellIndex += startRow < endRow ? -1 : 1
                }
                
                UIView.animateWithDuration(animationDuration,
                    animations: { [unowned self, weak cell = cell] in
                        cell?.center.y = self.cellSize.height*CGFloat(newCellIndex) + self.cellSize.height/2
                    },
                    completion: { [weak cell = cell] (completed) -> Void in
                        cell?.layer.zPosition = lowZPosition
                    }
                )
            }
        }
    }
    
    /// Animate the reposition of a block from one position to another.
    private func repositionBlockWithAnimation(#from: Int, to: Int) {
        let row = from
        let originalX = originalPosition!.x
        let cell = viewController.tableView.cellForRowAtIndexPath(NSIndexPath(forRow: row, inSection: 0))
        cell?.layer.zPosition = highZPosition
        UIView.animateWithDuration(animationDuration,
            animations: { [weak cell = cell, cellHeight = cellSize.height] in
                cell?.center.x = originalX
                cell?.center.y = CGFloat(to) * cellHeight + cellHeight/2
            },
            completion: { [unowned self, weak cell = cell] (completed) -> Void in
                cell?.layer.zPosition = self.lowZPosition
                var block = self.viewController.blocks.removeAtIndex(row)
                self.viewController.blocks.splice([block], atIndex: to)
                self.viewController.recalculateVanPosition()
            }
        )
    }
    
    /// Remove a block with animation
    private func removeBlockWithAnimation() {
        let row = selectedRow
        let cell = viewController.tableView.cellForRowAtIndexPath(NSIndexPath(forRow: row, inSection: 0))
        cell?.layer.zPosition = highZPosition
        UIView.animateWithDuration(animationDuration,
            animations: { [weak cell = cell, cellWidth = cellSize.width] in
                cell?.center.x -= cellWidth
            },
            completion: { [unowned self, weak cell = cell] (completed) -> Void in
                cell?.layer.zPosition = self.lowZPosition
                self.viewController.blocks.removeAtIndex(row)
                self.viewController.recalculateVanPosition()
            }
        )
    }
    
    /// Animate the reposition of other blocks when a block is removed.
    private func animateRowChangeBeforeBlockRemoval() {
        let row = selectedRow
        for index in row+1 ..< viewController.blocks.count {
            let cell = viewController.tableView.cellForRowAtIndexPath(NSIndexPath(forRow: index, inSection: 0))
            cell?.layer.zPosition = 0.9
            UIView.animateWithDuration(animationDuration,
                animations: { [weak cell = cell, cellHeight = cellSize.height] in
                    cell?.center.y -= cellHeight
                },
                completion: { [weak cell = cell] (completed) -> Void in
                    cell?.layer.zPosition = 0
                }
            )
        }
    }
    
}
