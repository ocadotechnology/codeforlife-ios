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
    var viewController: UIViewController
    var url: String

    init(viewController: UIViewController, url: String) {
        self.viewController = viewController
        self.url = url
        super.init(delegate: APIActionDelegate(url: url, method: Alamofire.Method.GET))
    }
    
    override func processData(data: NSData) {
        
        var levels = [Level]()
        
        let json = JSON(data: data)
        if let levelArray = json["level_set"].array {
            for level in levelArray {
                if let name = level["name"].string {
                    if let url = level["url"].string {
                        if let title = level["title"].string {
                            levels.append(Level(name: name, title: title, url: url))
                        } else {
                            levels.append(Level(name: name, title: "TODO", url: url))
                        }
                    }
                }
            }
        }
        
        if let viewController = self.viewController as? LevelTableViewController {
            viewController.levels = levels
        }
    }
    
    override func switchToDev() -> Action {
        return self
    }
    
    override func switchToMock() -> Action {
        self.delegate = FetchLevelsActionMockDelegate()
        return self
    }
    
}
