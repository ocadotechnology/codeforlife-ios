//
//  FetchLevelsActionMockDelegate.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 18/06/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

class FetchLevelsActionMockDelegate: ActionDelegate
{
    
    func execute(processData: (NSData -> Void), callback: () -> Void) {
        var json = JSON(
            [
                ["level": 1, "description": "Can you help the van get to the house?"],
                ["level": 2, "description": "This time the house is further away."],
                ["level": 3, "description": "Can you make the van turn right?"],
                ["level": 4, "description": "You are getting good at this! Let's try turning left."]
            ])
        
        var data = json.rawData()
        processData(data!)
        callback()
    }
}