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
    
    var startPosition: CGPoint?
    var selectedRow: Int?
    weak var selectedCell: UITableViewCell?
    var originalPosition: CGPoint?
    var verticalMode = false
    var horizontalMode = false
    var editable = true
    let animationDuration: NSTimeInterval = 0.5
    let cellHeight: CGFloat = 90
    let cellWidth: CGFloat = 250
    
    init(viewController: BlockTableViewController) {
        self.viewController = viewController
        super.init(target: viewController, action: Selector("handlePanGesture:"))
        self.minimumNumberOfTouches = 1
        self.maximumNumberOfTouches = 1
    }
    
    func handlePanGesture(sender:UIPanGestureRecognizer) {
        if editable {
            if (sender.state == UIGestureRecognizerState.Began) {
                recordStartPosition(sender.locationInView(viewController.tableView))
                
            } else if (sender.state == UIGestureRecognizerState.Ended) {
                let stopPosition = sender.locationInView(viewController.tableView)
                let indexPath = viewController.tableView.indexPathForRowAtPoint(stopPosition)
                let dx = startPosition!.x - stopPosition.x
                if selectedCell != nil && selectedRow != nil {
                    if horizontalMode && dx > 150 {
                        removeBlockAnimations()
                        removeBlockWithAnimation()
                    } else if verticalMode {
                        let translation = sender.translationInView(viewController.tableView)
                        let destinationRow = getDestinationRow(translation)
                        repositionBlockAnimations(startRow: selectedRow!, endRow: destinationRow)
                        repositionBlockWithAnimation(selectedRow!, to: destinationRow)
                    } else if originalPosition != nil {
                        selectedCell?.center = originalPosition!
                    }
                }
                resetPanGestureVariables()
            } else if (sender.state == UIGestureRecognizerState.Changed) && selectedCell != nil {
                let translation = sender.translationInView(viewController.tableView)
                if horizontalMode {
                    selectedCell!.center.x = originalPosition!.x + translation.x
                } else if verticalMode {
                    selectedCell!.center.y = originalPosition!.y + translation.y
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
    }
    
    private func resetPanGestureVariables() {
        selectedCell?.layer.zPosition = 0
        startPosition = nil
        selectedRow = nil
        selectedCell = nil
        originalPosition = nil
        verticalMode = false
        horizontalMode = false
    }
    
    // Record StartPosition and Selected Cell
    private func recordStartPosition(position: CGPoint) {
        startPosition = position
        if let indexPath = viewController.tableView.indexPathForRowAtPoint(startPosition!) {
            if indexPath.row != 0 {
                selectedRow = indexPath.row
                selectedCell = viewController.tableView.cellForRowAtIndexPath(indexPath)
                selectedCell?.layer.zPosition = 1
                originalPosition = selectedCell?.center
            }
        }
    }
    
    private func getDestinationRow(translation: CGPoint) -> Int {
        var destinationRow = Int(floor((selectedCell!.center.y - cellHeight/2)/cellHeight))
        destinationRow += translation.y < 0 ? 1 : 0
        destinationRow = max (1, min(destinationRow , viewController.blocks.count-1))
        return destinationRow
    }
    
    private func repositionBlockAnimations(#startRow: Int, endRow: Int) {
        if startRow != endRow {
            let minRow = min(startRow, endRow) + (startRow < endRow ? 1 : 0)
            let maxRow = max(startRow, endRow) - (startRow > endRow ? 1 : 0)
            for index in minRow ... maxRow {
                UIView.animateWithDuration(animationDuration,
                    animations: { [unowned self] in
                        let cell = self.viewController.tableView.cellForRowAtIndexPath(NSIndexPath(forRow: index, inSection: 0))
                        cell?.center.y += startRow < endRow ? -self.cellHeight : self.cellHeight
                    }
                )
            }
        }
    }
    
    private func repositionBlockWithAnimation(from: Int, to: Int) {
        let row = from
        let originalX = originalPosition!.x
        UIView.animateWithDuration(animationDuration,
            animations: { [unowned self] in
                let cell = self.viewController.tableView.cellForRowAtIndexPath(NSIndexPath(forRow: row, inSection: 0))
                cell?.center.x = originalX
                cell?.center.y = CGFloat(to) * self.cellHeight + self.cellHeight/2
            },
            completion: { [unowned self] (completed) -> Void in
                var block = self.viewController.blocks.removeAtIndex(row)
                self.viewController.blocks.splice([block], atIndex: to)
            }
        )
    }
    
    private func removeBlockWithAnimation() {
        let row = selectedRow!
        UIView.animateWithDuration(animationDuration,
            animations: { [unowned self] in
                self.viewController.tableView.cellForRowAtIndexPath(NSIndexPath(forRow: row, inSection: 0))?.center.x -= self.cellWidth
            },
            completion: { [unowned self] (completed) -> Void in
                self.viewController.blocks.removeAtIndex(row)
                self.viewController.recalculateVanPosition()
            }
        )
    }
    
    private func removeBlockAnimations() {
        let row = selectedRow!
        for index in row+1 ..< viewController.blocks.count {
            UIView.animateWithDuration(animationDuration,
                animations: { [unowned self] in
                    self.viewController.tableView.cellForRowAtIndexPath(NSIndexPath(forRow: index, inSection: 0))?.center.y -= self.cellHeight
                }
            )
        }
        
    }
    
    
}
