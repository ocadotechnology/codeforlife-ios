//
//  StoryboardFactory.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 30/06/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import UIKit
import Foundation

class StoryboardFactory {
    
    static var activeStoryboard: UIStoryboard?
    
    private struct StoryBoardIdentifier {
        static let GameMenu = "GameMenuViewController"
        static let DirecDrive = "DirectDriveViewController"
        static let Blockly = "BlockTableViewController"
        static let Message = "MessageViewController"
        static let GameMap = "GameMapViewController"
    }
    
    static func BlocklyViewControllerInstance() -> BlockTableViewController {
        return activeStoryboard!.instantiateViewControllerWithIdentifier(StoryBoardIdentifier.Blockly) as! BlockTableViewController
    }
    
    
    static func GameMenuViewControllerInstance() -> GameMenuViewController {
        return activeStoryboard!.instantiateViewControllerWithIdentifier(StoryBoardIdentifier.GameMenu) as! GameMenuViewController
    }
    
    static func DirectDriveViewControllerInstance() -> DirectDriveViewController {
        return activeStoryboard?.instantiateViewControllerWithIdentifier(StoryBoardIdentifier.DirecDrive) as! DirectDriveViewController
    }
    
    static func MessageViewControllerInstance() -> MessageViewController {
        return activeStoryboard?.instantiateViewControllerWithIdentifier(StoryBoardIdentifier.Message) as! MessageViewController
    }
    
    static func GameMapViewControllerInstance() -> GameMapViewController {
        return activeStoryboard?.instantiateViewControllerWithIdentifier(StoryBoardIdentifier.GameMap) as! GameMapViewController
    }
    
}
