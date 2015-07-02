//
//  StoryboardFactory.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 30/06/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import UIKit
import Foundation

class ViewControllerFactory {
    
    static var storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
    
    private struct StoryBoardIdentifier {
        static let GameMenu = "GameMenuViewController"
        static let DirecDrive = "DirectDriveViewController"
        static let Blockly = "BlockTableViewController"
        static let Message = "MessageViewController"
        static let GameMap = "GameMapViewController"
    }
    
    static func BlocklyViewControllerInstance() -> BlockTableViewController {
        return storyboard.instantiateViewControllerWithIdentifier(StoryBoardIdentifier.Blockly) as! BlockTableViewController
    }
    
    
    static func GameMenuViewControllerInstance() -> GameMenuViewController {
        return storyboard.instantiateViewControllerWithIdentifier(StoryBoardIdentifier.GameMenu) as! GameMenuViewController
    }
    
    static func DirectDriveViewControllerInstance() -> DirectDriveViewController {
        return storyboard.instantiateViewControllerWithIdentifier(StoryBoardIdentifier.DirecDrive) as! DirectDriveViewController
    }
    
    static func MessageViewControllerInstance() -> MessageViewController {
        return storyboard.instantiateViewControllerWithIdentifier(StoryBoardIdentifier.Message) as! MessageViewController
    }
    
    static func GameMapViewControllerInstance() -> GameMapViewController {
        return storyboard.instantiateViewControllerWithIdentifier(StoryBoardIdentifier.GameMap) as! GameMapViewController
    }
    
}
