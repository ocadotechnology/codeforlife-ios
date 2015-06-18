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
        if let viewController = self.viewController as? LevelTableViewController {
            viewController.levels = [
                [
                    Level(number: 1, description: "Can you help the van get to the house?"),
                    Level(number: 2, description: "This time the house is further away."),
                    Level(number: 3, description: "Can you make the van turn right?")
                ],
                [
                    Level(number: 5, description: "Good work! You are ready for something harder."),
                    Level(number: 6, description: "Well done! Let's use all three blocks")
                ]
            ]
        }
    }
    
    
}
