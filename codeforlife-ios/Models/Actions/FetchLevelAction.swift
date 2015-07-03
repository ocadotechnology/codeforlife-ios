//
//  FetchLevelAction.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 03/07/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import UIKit
import Foundation
import SwiftyJSON
import Alamofire

class FetchLevelAction : Action, ActionProtocol
{
    
    var gameViewController: GameViewController
    var url: String
    
    init( _ gameViewController: GameViewController, _ url: String? = nil) {
        self.gameViewController = gameViewController
        self.url = url ?? gameViewController.level!.url
        super.init(delegate: APIActionDelegate(url: self.url, method: Alamofire.Method.GET))
    }
    
    override func processData(data: NSData) {
            
        let json = JSON(data: data)
        if let description = json["description"].string,
            hint = json["hint"].string,
            blocklyEnabled = json["blocklyEnabled"].bool,
            pythonEnabled = json["pythonEnabled"].bool,
            pythonViewEnabled = json["pythonViewEnabled"].bool,
            level = gameViewController.level {
                level.description = description
                level.hint = hint
                level.blocklyEnabled = blocklyEnabled
                level.pythonViewEnabled = pythonViewEnabled
                level.pythonEnabled = pythonEnabled
        }

    }
    
    override func switchToDev() -> Action {
        self.mode = DevMode
        return self
    }
    
    override func switchToMock() -> Action {
        self.mode = MockMode
        //TODO
        return self
    }
    
}