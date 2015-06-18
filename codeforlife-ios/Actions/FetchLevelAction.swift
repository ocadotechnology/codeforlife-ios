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
            viewController.levels = [[Level(number: 1), Level(number: 2), Level(number: 3)], [Level(number: 5), Level(number: 6)]]
        }
    }
    
    
}
