//
//  ActionFetchLevels.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 18/06/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import UIKit
import Foundation

class FetchLevelsAction : Action, ActionProtocol
{
    var viewController: UIViewController?

    init(viewController: UIViewController) {
        super.init(url: kCFLFetchLevelsAction, httpMethod: "POST")
        self.delegate = FetchLevelsActionMockDelegate()
        self.viewController = viewController
    }
    
    override func processData(data: NSDictionary) {
        var levels = Levels()
        levels.addSection("Getting Started")
        levels.getSection(0)?.addLevel(Level(number: 1, description: "Can you help the van get to the house?"))
        levels.getSection(0)?.addLevel(Level(number: 2, description: "This time the house is further away."))
        levels.getSection(0)?.addLevel(Level(number: 3, description: "Can you make the van turn right?"))
        
        if let viewController = self.viewController as? LevelTableViewController {
            viewController.levels = levels
        }
    }
    
    
}
