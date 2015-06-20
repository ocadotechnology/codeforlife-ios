//
//  FetchLevelsActionMockDelegate.swift
//  codeforlife-ios
//
//  Created by Joey Chan on 18/06/2015.
//  Copyright (c) 2015 Joey Chan. All rights reserved.
//

import Foundation
import SwiftyJSON

class FetchLevelsActionMockDelegate: ActionDelegate, ActionDelegateProtocol
{
    override func execute(request: NSMutableURLRequest, processData: (NSData -> Void)) {
        var json = JSON(
            [
                [
                    "section": "Getting Started",
                    "levels" :
                        [
                            ["level": 1, "description": "Can you help the van get to the house?"],
                            ["level": 2, "description": "This time the house is further away."],
                            ["level": 3, "description": "Can you make the van turn right?"],
                            ["level": 4, "description": "You are getting good at this! Let's try turning left."]
                        ]
                ],
                [
                    "section": "Shortest Route",
                    "levels":
                        [
                            ["level": 13, "description": "Multiple routes"],
                            ["level": 14, "description": "Can you spot the shortest route?"],
                            ["level": 15, "description": "What if there is more than one delivery?"]
                        ]
                ]
            ])
        
        
        var data = json.rawData()
        processData(data!)
    }
}