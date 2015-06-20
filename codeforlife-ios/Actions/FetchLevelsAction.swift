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
    var viewController: UIViewController?

    init(viewController: UIViewController) {
        super.init(url: kCFLFetchLevelsAction, httpMethod: "POST")
        self.delegate = FetchLevelsActionMockDelegate()
        self.viewController = viewController
    }
    
    override func processData(data: NSData) {
        
        var levels = Levels()
        
        let json = JSON(data: data)
        if let sectionArray = json.array {
            for section in sectionArray {
                if let sectionName = section["section"].string {
                    var newSection = levels.addSection(sectionName)!
                    if let levelArray = section["levels"].array {
                        for level in levelArray {
                            if let number = level["level"].int {
                                if let description = level["description"].string {
                                    newSection.addLevel(Level(number: number, description: description))
                                }
                            }
                        }
                    }
                }
            }
        }
        
        if let viewController = self.viewController as? LevelTableViewController {
            viewController.levels = levels
        }
    }
    
    
}
