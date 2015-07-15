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
    let cellHeight: CGFloat = 90
    
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
                        viewController.blocks.removeAtIndex(selectedRow!)
                    } else if verticalMode {
                        let destinationRow = Int(round(((stopPosition.y - cellHeight/2) / cellHeight) - 0.5))
                        repositionBlock(selectedRow!, to: max(1, min(destinationRow, viewController.blocks.count-1)))
                    } else if originalPosition != nil {
                        selectedCell?.center = originalPosition!
                    }
                }
                resetPanGestureVariables()
            } else if (sender.state == UIGestureRecognizerState.Changed) && selectedCell != nil {
                let translation = sender.translationInView(viewController.tableView)
                
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
    
    private func repositionBlock(from: Int, to: Int) {
        var block = viewController.blocks.removeAtIndex(from)
        viewController.blocks.splice([block], atIndex: to)
    }
    
    
}
