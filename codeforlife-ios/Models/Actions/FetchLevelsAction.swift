//
//  ActionFetchLevels.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 18/06/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import UIKit
import Foundation
import SwiftyJSON

class FetchLevelsAction : Action, ActionProtocol
{
    var viewController: UIViewController

    init(viewController: UIViewController, episode: Int) {
        self.viewController = viewController
        super.init()
        self.delegate = FetchLevelsActionDelegate(episode: episode)
    }
    
    override func processData(data: NSData) {
        
        var levels = [Level]()
        
        let json = JSON(data: data)
        println(json)
        if let levelArray = json.array {
            for level in levelArray {
                if let number = level["level"].int {
                    if let description = level["description"].string {
                        levels.append(Level(number: number, description: description))
                    }
                }
            }
        }
        
        if let viewController = self.viewController as? LevelTableViewController {
            viewController.levels = levels
        }
    }
    
    override func switchToDev() -> Action {
        self.delegate = FetchLevelsActionDevDeletage()
        return self
    }
    
    override func switchToMock() -> Action {
        self.delegate = FetchLevelsActionMockDelegate()
        return self
    }
    
}
