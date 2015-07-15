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
import Alamofire

class FetchLevelsAction : Action, ActionProtocol
{
    unowned var viewController: LevelTableViewController

    init( _ viewController: LevelTableViewController, _ url: String) {
        self.viewController = viewController
        super.init(
            devUrl: url,
            delegate: APIActionDelegate(url: url, method: Alamofire.Method.GET),
            mockDelegate: FetchLevelsActionMockDelegate())
    }
    
    override func processData(data: NSData) {
        var levels = [Level]()
        let json = JSON(data: data)
        if let levelArray = json["level_set"].array {
            for level in levelArray {
                if let name = level["name"].string,
                    url = level["url"].string,
                    title = level["title"].string {
                    var newLevel = Level(url: url, name: name, title: title)
                    levels.last?.nextLevel = newLevel
                    levels.append(newLevel)
                }
            }
        }
        viewController.levels = levels
    }
    
    deinit { println("FetchLevelsAction is being deallocated") }
    
}
